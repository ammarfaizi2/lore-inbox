Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289365AbSAOKaV>; Tue, 15 Jan 2002 05:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289460AbSAOKaL>; Tue, 15 Jan 2002 05:30:11 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:45323 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S289365AbSAOKaF>;
	Tue, 15 Jan 2002 05:30:05 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Memory problem with bttv driver
Date: 15 Jan 2002 10:17:03 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna480cv.68d.kraxel@bytesex.org>
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com> <E16QETz-0002yD-00@the-village.bc.nu> <20020115004205.A12407@werewolf.able.es>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1011089823 6414 127.0.0.1 (15 Jan 2002 10:17:03 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Making it bigger reduces that amount of ram directly mapped by the kernel 
> >which hits performance (nastily for 2.4 not so bad for 2.5)
>  
>  (Sorry for joning so late to the thread...)
>  It is wokring fine for me, under 2.4.18-pre3 + NVidia. The difference is
>  that I am using version 0.7.87 (see http://giga.cps.unizar.es/~magallon/linux/2.4.18-pre3/)
>  I have just checked the bttv page (http://bytesex.org/bttv/) and there is
>  a newer version (0.7.88). What comes in .17 is 0.7.83. I have not
>  noticed anything relevant in changelog, but you can try...

MM wise it shouldn't make a difference whenever you are using 0.7.83 or
0.7.88 (I've mailed 0.7.88 patches to macelo for 2.4.18 btw).  The 0.8.x
versions have a complete different way to do the memory management.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
