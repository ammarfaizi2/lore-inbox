Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSIZOp7>; Thu, 26 Sep 2002 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSIZOp7>; Thu, 26 Sep 2002 10:45:59 -0400
Received: from [211.91.168.220] ([211.91.168.220]:50951 "HELO jmly-gc8930q6iv")
	by vger.kernel.org with SMTP id <S261317AbSIZOp6>;
	Thu, 26 Sep 2002 10:45:58 -0400
Date: Thu, 26 Sep 2002 22:52:23 +0800
From: immortal1015 <immortal1015@52mail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: A newbie's question
X-mailer: FoxMail 4.0 beta 1 [cn]
Message-Id: <20020926144558Z261317-8740+1711@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all. I am a newbie to Linuxe Kernel. I am reading the kernel source about bootstrap in Linux.
I was confused by the boot.s:
/////////////////////////////
   	mov	ax,#BOOTSEG
	mov	ds,ax
	mov	ax,#INITSEG
	mov	es,ax
	mov	cx,#256
	sub	si,si
	sub	di,di
	rep
	movw
	jmpi	go,INITSEG
/////////////////////////////
1. What assembly language used in boot.s? Intel Asm or AT&T?
2. Where is the definition of operand movw and jmpi? I cant find it in the Intel Manual.

Please give me some adivices.

Best regards.


