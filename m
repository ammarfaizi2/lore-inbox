Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281514AbRKMFoZ>; Tue, 13 Nov 2001 00:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRKMFoQ>; Tue, 13 Nov 2001 00:44:16 -0500
Received: from codepoet.org ([166.70.14.212]:31016 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S281514AbRKMFoL>;
	Tue, 13 Nov 2001 00:44:11 -0500
Date: Mon, 12 Nov 2001 22:44:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
Message-ID: <20011112224412.A6606@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca> <Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu> <200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca> <3BF09E44.58D138A6@mandrakesoft.com> <200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca> <3BF0A788.8CCBC91@mandrakesoft.com> <200111130500.fAD50Wi17879@vindaloo.ras.ucalgary.ca> <3BF0AC47.221B6CD6@mandrakesoft.com> <200111130523.fAD5NRK18457@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111130523.fAD5NRK18457@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 12, 2001 at 10:23:27PM -0700, Richard Gooch wrote:
> 
> A few days ago I was thinking about this, and I thought how cool it
> would be to have a reliable utility that could convert between the two
> coding styles. If I had that (and it was bulletproof) then it could be
> used with some kind of userfs to give me two views of the kernel: the
> underlying one "raw" one, to which I'd apply patches and generate them
> from, and a "sanitised" one, that I would read and edit.

If you look in scripts/Lindent you will see it calls:
    indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl

The GNU indent utility has tons of options to accomodate every
sort of perverse coding style.  I imagine some time with the
indent man page will produce a working solution for you in short
order,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
