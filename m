Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSGUNec>; Sun, 21 Jul 2002 09:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSGUNec>; Sun, 21 Jul 2002 09:34:32 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:49039 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315779AbSGUNeb> convert rfc822-to-8bit; Sun, 21 Jul 2002 09:34:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: heavy Disk I/O and system stops reacting for seconds
Date: Sun, 21 Jul 2002 15:37:23 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207211537.03813.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I think someone else notices this too, but anyway, i write down my 
experiences.

I've tested 2.4.19rc[1|2|3], AC tree, AA tree, jam tree and mjc tree
All of them shows up the same behaviour. If i do some disk i/o, f.e.:

tar xzpf linux-2.4.18.tar.gz; rm -rf linux-2.4.18

the system stopps reacting while untar/ungzipping the file for more than 5 
seconds. Nothing but the mouse reacts. This does NOT occur with 2.4.18 and 
early 2.4.19-pre's ...

System is a Celeron 800MHz, 256 MB RAM, EIDE UDMA100 Intel BX440 running ext3 
filesystem.

If you need more informations tell me what and I provide them.
If this is already fixed by someone, please tell me :-)

Please CC, i am not subscribed!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
