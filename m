Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129505AbQKHWMY>; Wed, 8 Nov 2000 17:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129611AbQKHWMN>; Wed, 8 Nov 2000 17:12:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44809 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129505AbQKHWMG>; Wed, 8 Nov 2000 17:12:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: malloc(1/0) ??
Date: 8 Nov 2000 14:11:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ucj2m$oiq$1@cesium.transmeta.com>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com> <Pine.LNX.4.21.0011080149010.32613-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0011080149010.32613-100000@server.serve.me.nl>
By author:    Igmar Palsenberg <maillist@chello.nl>
In newsgroup: linux.dev.kernel
>
> 
> > 	The program does not work. A program works if it does what it's supposed to
> > do. If you want to argue that this program is supposed to print "ffffff"
> > then explain to me why the 'malloc' contains a zero in parenthesis.
> > 
> > 	The program can't possibly work because it invokes undefined behavior. It
> > is impossible to determine what a program that invokes undefined behavior is
> > 'supposed to do'.
> 
> May I remind you guys that a malloc(0) is equal to a free(). There is no
> way that any mem get's malloced. 
> 

Where the heck did you get idea?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
