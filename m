Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264364AbTCUXxR>; Fri, 21 Mar 2003 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264366AbTCUXxR>; Fri, 21 Mar 2003 18:53:17 -0500
Received: from hexagon.stack.nl ([131.155.140.144]:33800 "EHLO
	hexagon.stack.nl") by vger.kernel.org with ESMTP id <S264364AbTCUXxP>;
	Fri, 21 Mar 2003 18:53:15 -0500
Date: Sat, 22 Mar 2003 01:04:15 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2 (fwd)
In-Reply-To: <418110000.1048277112@aslan.btc.adaptec.com>
Message-ID: <20030322010217.G11941-100000@snail.stack.nl>
References: <Pine.LNX.4.50.0303210217370.2133-100000@montezuma.mastecende.com>
 <200303211243.31104.josh@stack.nl> <418110000.1048277112@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Justin T. Gibbs wrote:

> > Hi
> >
> > Similar issues here., though I must say the Adaptec driver hasn't worked for
> > me on all kernels I tried since my first try with 2.5.44. I get almost the
> > same output with a plain 2.5.65 kernel, though my kernel locks up just before
> > the crash you get, I get no dmesg output.
> >
> > Note that it takes ages to get trough the SCSI driver towards the lockup. I
> > guess some timeouts cause this.
>
> What kind of MB are you using?  It sounds like interrupts aren't working
> for you.

Intel 440 LX chipset with MPS 1.4 enabled, onboard Adaptec controller. Can
try to disable MPS 1.4, have seen drivers using wrong irq info before.
Results will follow later.

Jos
