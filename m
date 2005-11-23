Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVKWSfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVKWSfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVKWSfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:35:21 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:49421 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932150AbVKWSfT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:35:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=phaXfm7V3pGm29PHauKQv+vGmiAphhJ6CiKKh1l8ZCs/r7f773GSSFfN9aDIDPfTMTQffUBASca5Knj7LCdZ5XvvKIatYdi9xq2J7WLTC16MT7gr/MIdrUVyfGcofPIfwTSgHSGIO/IL5BsYV4Mr5hiCAaL1D0QH9EUdJO19gqI=
Message-ID: <2ea3fae10511231035y5466a793y829688f5532ad32e@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:35:19 -0800
From: yhlu <yinghailu@gmail.com>
To: Stefan Reinauer <stepan@openbios.org>
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linuxbios@openbios.org,
       yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <2ea3fae10511231022g3a690870qf4564b085c24cb20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
	 <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov>
	 <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com>
	 <20051123173636.GL20775@brahms.suse.de>
	 <2ea3fae10511230940t1f6a1757lf885a2559be6f0dc@mail.gmail.com>
	 <20051123181804.GC27398@openbios.org>
	 <2ea3fae10511231022g3a690870qf4564b085c24cb20@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it doesn't work. At that case must disable the apci in kernel...(acpi=off)

YH

On 11/23/05, yhlu <yinghailu@gmail.com> wrote:
> only RSDT+SRAT?, I will try it....
>
> YH
>
> On 11/23/05, Stefan Reinauer <stepan@openbios.org> wrote:
> > * yhlu <yinghailu@gmail.com> [051123 18:40]:
> > > is there any way to make the kernel use apci but still use pci irq
> > > routing from mptable?
> >
> > Yes, don't provide any of MADT, DSDT, FADT.
> >
> >    Stefan
> >
> >
>
