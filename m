Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSATFui>; Sun, 20 Jan 2002 00:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSATFu2>; Sun, 20 Jan 2002 00:50:28 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:57359
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S288005AbSATFuR>; Sun, 20 Jan 2002 00:50:17 -0500
Message-Id: <5.1.0.14.2.20020120003815.01e2d008@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 20 Jan 2002 00:42:59 -0500
To: Rob Landley <landley@trommello.org>,
        "David Luyer" <david_luyer@pacific.net.au>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Oliver Xymoron'" <oxymoron@waste.org>
From: Stevie O <stevie@qrpff.net>
Subject: Re: vm philosophising
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020120020228.SNES23469.femail45.sdc1.sfba.home.com@there
 >
In-Reply-To: <004301c1a0a3$bd172a90$46943ecb@pacific.net.au>
 <004301c1a0a3$bd172a90$46943ecb@pacific.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why don't we all follow the MSCommit method of VM? We simply allocate 99% 
of physical RAM for cache and other non-userspace purposes, and whenever an 
application needs memory, pop up a message:
         printk("Your system is out of virtual memory. Linux is increasing 
your virtual memory size. During this time, memory allocation requests may 
fail.\n");

Then spend a few minutes doing hard disk I/O, while exposing bugs in 
programs that don't check to make sure that malloc succeeded.


;)



--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

