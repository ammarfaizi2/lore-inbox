Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUIBFq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUIBFq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUIBFqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:46:55 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:42000 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267350AbUIBFqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:46:31 -0400
Message-ID: <4699bb7b04090122465214bcd7@mail.gmail.com>
Date: Thu, 2 Sep 2004 17:46:26 +1200
From: Oliver Hunt <oliverhunt@gmail.com>
Reply-To: Oliver Hunt <oliverhunt@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Time runs exactly three times too fast
Cc: Romain Moyne <aero_climb@yahoo.fr>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1094069950.14662.208.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409021453.09730.aero_climb@yahoo.fr> <1094069950.14662.208.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A friend of mine had a similar problem when updating his debian system
last night, so is this a problem with the current debian patch set?

Apparently it went away after playing with acpi, so maybe it is the PM
time source...

--Oliver


On Wed, 01 Sep 2004 13:19:11 -0700, john stultz <johnstul@us.ibm.com> wrote:
> On Thu, 2004-09-02 at 05:53, Romain Moyne wrote:
> > Hello, I'm french, sorry for my bad english :(
> >
> > I have a problem with my kernel: Time runs exactly three times too fast.
> >
> > I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success.
> > It is really strange because yesterday I reinstalled my debian with a kernel
> > 2.6.8.1 (made by me): Time ran correctly. And this morning when I rebooted my
> > computer (Compaq presario R3000 series, R3215EA exactly) the time is running
> > again three times too fast (with the kernel 2.6.8.1 and 2.6.9-rc1).
> 
> Hmmm. First of all, if you enable the ACPI PM Time source, does the
> problem go away?
> 
> thanks
> -john
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
