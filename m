Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318379AbSHEL2s>; Mon, 5 Aug 2002 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318381AbSHEL2s>; Mon, 5 Aug 2002 07:28:48 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:34029 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318379AbSHEL2r> convert rfc822-to-8bit; Mon, 5 Aug 2002 07:28:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19' drivers/block/ll_rw_blk.c
Date: Mon, 5 Aug 2002 12:23:29 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Adrian Bunk <bunk@fs.tum.de>
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208051223.29329.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

could you please consider changing those very slow behaviour in 
"drivers/block/ll_rw_blk.c"? ... Benchmarked against 2.4.18 this is horribly 
slower ... Doing some heavy disk i/o, want to start another thing, system 
freeze for some seconds ... Opening a xterm , Ctrl-D to leave, this takes 
about 5 seconds and somewhat is doing flushing to the disk.

Maybe req_finished_io ?

Adrian, could this be the problem you've experienced?

Afaik this was changed for 2.4.19-pre7 and above.

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
