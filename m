Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284617AbRLHUGL>; Sat, 8 Dec 2001 15:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284620AbRLHUGE>; Sat, 8 Dec 2001 15:06:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34060 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284617AbRLHUFp>;
	Sat, 8 Dec 2001 15:05:45 -0500
Date: Sat, 8 Dec 2001 21:05:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Ivanovich <ivanovich@menta.net>
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Impact of HIGHMEM?
Message-ID: <20011208200529.GA11567@suse.de>
In-Reply-To: <3C1263FE.EBD973FA@starband.net> <01120820485101.01267@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01120820485101.01267@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08 2001, Ivanovich wrote:
> A Dissabte 08 Desembre 2001 20:03, war va escriure:
> > Does anyone have any benchmarks as to how much HIGHMEM affects
> > performance in Linux?
> >
> > Searched google.com + groups.google.com, couldn't find anything solid
> > though.
> 
> why don't you try to compile a kernel with HIGHMEM and another without it and 
> then run some benchmarks in each one and compare?

You'll very quickly spend a significant amount of sys time copying pages
back and forth. 

> not everyone have the amount of ram to test this (i only have 
> 256...(sigh)) if i had that amount i would run some bench...

You don't need lots of mem to test highmem impact, just grab the highmem
debug patch from Andrea:

kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17pre4aa1/20_highmem-debug-7

-- 
Jens Axboe

