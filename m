Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUCBT6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUCBT6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:58:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261757AbUCBT6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:58:19 -0500
Date: Tue, 2 Mar 2004 14:58:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Meadors <clubneon@hereintown.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Better performance with 2.6
In-Reply-To: <1078257097.7380.31.camel@clubneon.priv.hereintown.net>
Message-ID: <Pine.LNX.4.53.0403021455380.1605@chaos>
References: <1078229894.53b994c0albhaf@home.se>  <20040302195155.0384abdc.albhaf@home.se>
  <Pine.LNX.4.53.0403021406560.1166@chaos> <1078257097.7380.31.camel@clubneon.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Chris Meadors wrote:

> On Tue, 2004-03-02 at 14:10, Richard B. Johnson wrote:
>
> > Are you talking about BogoMips??  This is just how many twinkies
> > you can eat in a second with the current coding style in the
> > short timer counter. It has absolutely, positively, nothing to
> > do with "CPU capacity".
>
> He probably meant MHz.  But the same thing.  What difference does a
> tenth of a MHz matter?
>
> I do have a question about BogoMIPS.  I know they don't mean anything,
> but why on my Opteron system with two processors that read the same on
> the cpu MHz line, do my bogomips vary so much?
>
> processor       : 0
> cpu MHz         : 1393.980
> bogomips        : 2736.12
>
> processor       : 1
> cpu MHz         : 1393.980
> bogomips        : 3145.72
>

Because the loop-counter is called at different times, therefore
the cache has different stuff in it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


