Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTEFPe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTEFPe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:34:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36481 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263817AbTEFPdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:33:50 -0400
Date: Tue, 6 May 2003 11:48:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Simon Kelley <simon@thekelleys.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
In-Reply-To: <20030506151644.GA19898@fieldses.org>
Message-ID: <Pine.LNX.4.53.0305061139020.6723@chaos>
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org>
 <20030506151644.GA19898@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, J. Bruce Fields wrote:

> On Tue, May 06, 2003 at 03:19:54PM +0300, Matti Aarnio wrote:
> > On Tue, May 06, 2003 at 12:38:54PM +0100, Simon Kelley wrote:
> > > I shall contact Atmel for advice and clarification but my question for
> > > the list is, what should I ask them to do? It's unlikely that they will
> > > release the source to the firmware and even if they did I wouldn't want
> > > firmware source  in the kernel tree since the kernel-build toolchain
> > > won't be enough to build the firmware. What permissions do they have to
> > > give to make including this stuff legal and compatible with the rest of
> > > the kernel?
> >
> > Adding a phrase like:  "This firmware binary block is intended to be
> > used in BSD/GPL licensed driver"   would definitely clarify it.
> > Possibly adding:
> >   "Source code/further explanations for this binary block
> >    are available at file FFFF.F / are not available."
>
> It's not Atmel whose permission you need to do this, it's the other
> kernel developers whose permission you need.  By releasing their code
> under the GPL, the people who hold copyright on all the other kernel
> code have essentially given you permission to modify and redistribute
> their code as long as you make source available for the resulting work.
>
> The question is whether adding this binary blob to the linux kernel
> violates the license that the kernel developers gave you.  I can't see
> how Amtel saying it's OK would make it so.
>
> --Bruce Fields

I don't see anybody sending the contents of the PALs, ASICs, and
other components on your motherboard. Modern machines have all
those bits loaded upon power-up. Before the power is applied,
the components aren't even connected. The same is true for
many disk drive boards, screen-card boards, etc. The manufacturer
will supply a bucket of bits, plus instructions on how to
load them into the hardware. I don't see how this violates either
the wording or the spirit of GPL. The manufacturer certainly
isn't going to supply the "source", which is the output of a
graphical program where the Engineers spent the last year
designing the board. If this kind of BS continues, Linux
will go the way of the Hippie culture.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

