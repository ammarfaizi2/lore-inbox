Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSLHBFx>; Sat, 7 Dec 2002 20:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSLHBFx>; Sat, 7 Dec 2002 20:05:53 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:48821 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265066AbSLHBFw>; Sat, 7 Dec 2002 20:05:52 -0500
Subject: Re: IDE feature request
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <068d01c29d97$f8b92160$551b71c3@krlis>
References: <068d01c29d97$f8b92160$551b71c3@krlis>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 01:48:55 +0000
Message-Id: <1039312135.27904.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 02:25, Milan Roubal wrote:
> I tryed to patch the kernel by myself, so it works,
> but the patch is only change magic number 10 to 12.
> I have got this:
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x3020-0x3027,0x3016 on irq 11
> ide3 at 0x3018-0x301f,0x3012 on irq 11
> ide4 at 0x5040-0x5047,0x5036 on irq 12
> ide6 at 0x5058-0x505f,0x504e on irq 12
> ide7 at 0x5050-0x5057,0x504a on irq 12
> ide8 at 0x5070-0x5077,0x5066 on irq 12
> ide9 at 0x5068-0x506f,0x5062 on irq 12
> ide: at 0x6020-0x6027,0x6016 on irq 12
> ide; at 0x6018-0x601f,0x6012 on irq 12
> so ":" and ";" isn't ideal, hdparm dislikes 

Fix ide.c to generate a b c d e f and you should be able to get 16.


