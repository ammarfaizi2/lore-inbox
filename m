Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRHPVD6>; Thu, 16 Aug 2001 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267911AbRHPVDs>; Thu, 16 Aug 2001 17:03:48 -0400
Received: from rom.cscaper.com ([216.19.195.129]:57224 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S267883AbRHPVDi>;
	Thu, 16 Aug 2001 17:03:38 -0400
Subject: Problems with PCMCIA IDE interface in laptop
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Ccc: 
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 16 Aug 2001 14:04 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20010816210338Z267883-760+2564@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been unable to get my laptop to work with a PCMCIA
IDE adapter.  Actually I've tried two, an EZ-GIG and another one
that I had from a couple years back.

The overall effect is:

Aug 15 17:33:27 parrotnoid cardmgr[506]: initializing socket 0 
Aug 15 17:33:27 parrotnoid cardmgr[506]: socket 0: ATA/IDE Fixed Disk 
Aug 15 17:33:27 parrotnoid cardmgr[506]: executing: 'modprobe ide-cs' 
Aug 15 17:33:28 parrotnoid cardmgr[506]: get devinfo on socket 0 failed: Resource temporarily unavailable 

What does the "resource temporarily unavailable" message mean?  Is this
a race condition?

Sometimes there is an additional line from cs about the memory
mapping, but that's all.  I never see any hd(x) messages from the kernel.

I have more comments in my posting to the sourceforge PCMCIA forum:

http://sourceforge.net/forum/forum.php?forum_id=33430

Basically I can see the card okay but the ide driver seems unable to
cope with it.

Machine is a FIVA MPC-206e.  Kernel is 2.4.8.  Using kernel PCMCIA and
up-to-date Card Services.

  -joseph

--
Joseph N. Hall
Author, Effective Perl Programming
