Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSGJP4Q>; Wed, 10 Jul 2002 11:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317528AbSGJP4P>; Wed, 10 Jul 2002 11:56:15 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:48842 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317525AbSGJP4O> convert rfc822-to-8bit; Wed, 10 Jul 2002 11:56:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: Booting problems with Compaq ML570 >2 CPUs
Date: Wed, 10 Jul 2002 17:58:28 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207101758.28028.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

does anyone have a clue what can cause a hard reset with a Compaq ML570 Quad 
CPU System? If i use "maxcpus=2" the kernel boots fine and works fine, if i 
boot with "maxcpus=3" i see "Loading Linux..." and then hard reset, if i use 
maxcpus=4 the same, if i use "noapic" also the same.

I totally have no clue about it and also don't see any error messages, also 
not with early printk() patch from William Lee Irwin III.

This is with 2.4.18, 2.4.19rc1, 2.4.19rc1-aa2, 2.4.19-rc1-aa2-jam2 and my 
kernel tree wolk 3.5.

For anyone who don't know the mashine:
http://www.compaq.com/products/servers/proliantml570/description.html

Please CC, I am not subscribed to the mailinglist.

-- 
Kind regards,
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
