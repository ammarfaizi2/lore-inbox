Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWEONEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWEONEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEONEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:04:13 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:11214 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932403AbWEONEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:04:12 -0400
Date: Mon, 15 May 2006 09:04:11 -0400
To: Krishna Chaitanya <lnxctnya@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux for Asymmetric Multi Processing Systems.
Message-ID: <20060515130411.GD23931@csclub.uwaterloo.ca>
References: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com> <20060512185426.GC2837@csclub.uwaterloo.ca> <ae649ba00605130510p6435e756h86f310f814c14b66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae649ba00605130510p6435e756h86f310f814c14b66@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 05:40:54PM +0530, Krishna Chaitanya wrote:
> Each Processor has its own RAM and the main ARM9 processor can access
> the ARM7 Memory Map through a _Shared RAM_.
> 
> In other words, the Memory Map of ARM7 processors is visible to ARM9 
> processor.
> 
> Finally there are 3 RAMs:
> 1) System RAM (ARM9)
> 2) Shared RAM (the Common Memory)
> 3) Local RAM for ARM7s.
> 
> Basically, this is a _flexible_ mechanism to control the _visibility_
> of Each Processor.
> 
> And the Memory Controller can do either _cached_ or _non-cached_ operations.

Sounds like a neat system.  I am not sure I would know what to do with
one. :)

It does however sound like the methods used for the Cell based systems
might apply reasonably to it.  The main OS runs on the main CPU, and
executes tasks on the other processors by transfering the task to them
and retreiving the results later when it is ready.

Len Sorensen
