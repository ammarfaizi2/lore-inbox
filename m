Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWCAALs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWCAALs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCAALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:11:48 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:13792 "EHLO
	suzuka.mcnaught.org") by vger.kernel.org with ESMTP id S932129AbWCAALs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:11:48 -0500
To: kilampka@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Max mem space per process under  2.6.13-15.7-smp
References: <1141170947.23172.18.camel@pclampka.informatik.unibw-muenchen.de>
From: Douglas McNaught <doug@mcnaught.org>
Date: Tue, 28 Feb 2006 19:11:45 -0500
In-Reply-To: <1141170947.23172.18.camel@pclampka.informatik.unibw-muenchen.de> (Kai
 Lampka's message of "Wed, 01 Mar 2006 00:55:47 +0100")
Message-ID: <87zmkbm3b2.fsf@suzuka.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Lampka <kilampka@gmail.com> writes:

> Sorry to bother, 
> but what is the maximum amount of RAM that a *single* (!) process can
> address under a Kernel version 2.6.13-15.7-smp, with 
>
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
>
> It seems that I can not get over 3 Gig border, but i need to, to solve
> my numerical problems :(.

I've heard of a kernel patch that gives you 3.5GB (leaving 0.5 for
the kernel) but you're not going to get any more than that without
buying a 64-bit machine or playing overlay tricks with mmap().  Given
the price and performance of 64-bit hardware, the former option is
probably a lot better.

-Doug
