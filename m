Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVALRKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVALRKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 12:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVALRKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 12:10:39 -0500
Received: from orb.pobox.com ([207.8.226.5]:26252 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261256AbVALRKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 12:10:35 -0500
Date: Wed, 12 Jan 2005 09:10:22 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Barry K. Nathan" <barryn@pobox.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Lang <dlang@digitalinsight.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112171022.GH4325@ip68-4-98-123.oc.oc.cox.net>
References: <20050111235907.GG2760@pclin040.win.tue.nl> <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost> <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com> <20050111223641.GA27100@logos.cnet> <20050112023218.GF4325@ip68-4-98-123.oc.oc.cox.net> <20050112005647.GB27653@logos.cnet> <20050112061043.GG4325@ip68-4-98-123.oc.oc.cox.net> <20050112164729.GJ29578@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112164729.GJ29578@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 05:47:29PM +0100, Adrian Bunk wrote:
> The only interesting correlation are system calls that are _only_ used 
> by libc4/libc5 applications.

Well, in theory it might be possible to create a sadistic libc6 app that
also uses old system calls anyway. I'm hoping that isn't common.

> Make such a patch, test it thoroughly and then send it here for review.
> 
> It can't be guaranteed that your patch will be accepted, but as soon as 
> you'll present the patch the discussion will become more flesh.

Right.

I don't want to commit to an exact timeline, but this is something I'm
planning to do soon.

-Barry K. Nathan <barryn@pobox.com>
