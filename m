Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272276AbTHSP3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272290AbTHSP3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:29:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55680 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272276AbTHSP3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:29:11 -0400
Date: Tue, 19 Aug 2003 11:31:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bart Samwel <bart@samwel.tk>
cc: Brandon Stewart <rbrandonstewart@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: SCO's "proof"
In-Reply-To: <3F423D35.7010603@samwel.tk>
Message-ID: <Pine.LNX.4.53.0308191129540.6161@chaos>
References: <3F422809.7080806@yahoo.com> <3F423D35.7010603@samwel.tk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Bart Samwel wrote:

> For those of you who don't speek greek, the greek text is English and reads:
>
> "As part of the kernel evolution towords modular naming, the functions
> malloc and free are being renamed to rmalloc and rfree.
> Compatibility will be maintained by the following assembler code:
> (also see free/malloc below)"
>
> What a way of obfuscating their IP. :)
>
> Bart
>
> Brandon Stewart wrote:
>
> > compliments of "d1rkinator" from yahoo finance message board:
> >
> > The code SCO finds offending:
> >
> > www.heise.de/newsticker/data/jk-19.08.03-000/imh0.jpg
> > www.heise.de/newsticker/data/jk-19.08.03-000/imh1.jpg
> >
> > Its location in Linux:
> >
> > /usr/src/linux-2.4.20/arch/ia64/sn/io/ate_utils.c
> >
> > And its heritage:
> >
> > minnie.tuhs.org/UnixTree/V7/usr/sys/sys/malloc.c.html
> >
> > Ok, SCO: This was easy. Now, show us the other many examples.
> >
> >
> > -

confuse.S follows.
----------------
#
#  Enormously complicated assembly-language program released
#  under GPL, herein referenced ;)
#
#  This program will actually work. Am I violating somebody's
#  patent? Sue me.
#
.section	.text
rmalloc:	jmp	malloc
rfree:		jmp	free
print:		jmp	printf	# Fix typical typos
.global	rmalloc
.type	rmalloc,@function
.global	rfree
.type	rfree,@function
.global	print
.type	print,@function
.end
---------------


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


