Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263913AbTCUWMy>; Fri, 21 Mar 2003 17:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263912AbTCUWLn>; Fri, 21 Mar 2003 17:11:43 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:36826 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id <S263890AbTCUWKT>;
	Fri, 21 Mar 2003 17:10:19 -0500
Subject: This disc doesn't have any tracks I recognize!
From: Max Valdez <maxvaldez@yahoo.com>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048285354.4741.36.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Mar 2003 16:22:34 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having that message sent to logs too many times when i have a blank
disc on my drive.

Is there any way to have that message sent only once unles the disc
remains in the drive ??

I had a 700Gb log file one night i forgot to unplug the CD-RW with an
empty disc

Sorry for the silly question, I dont know a lot of C, and even less
kernel coding.

the problem is line 2648 on drivers/cdrom/cdrom.c
cdinfo(CD_WARNING,"This disc doesn't have any tracks I recognize!\n");

I could comment that line out, but i would love a better solution before
recompiling my kernel. btw. this is on 2.4.21pre5-ac3.

Thanks for any comment
Max

-- 
Nunca ! Jamas !

