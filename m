Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbUCZFAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUCZFAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:00:10 -0500
Received: from alt.aurema.com ([203.217.18.57]:51086 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263936AbUCZE74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:59:56 -0500
Date: Fri, 26 Mar 2004 15:59:51 +1100 (EST)
From: John Lee <johnl@aurema.com>
X-X-Sender: johnl@johnl.sw.oz.au
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O(1) Entitlement Based Scheduler v1.1
In-Reply-To: <20040326011325.53275600.ak@suse.de>
Message-ID: <Pine.LNX.4.44.0403261525550.8120-100000@johnl.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004, Andi Kleen wrote:

> On Fri, 26 Mar 2004 11:02:36 +1100 (EST)
> John Lee <johnl@aurema.com> wrote:
> 
> > I'm glad to hear that the interactivity now works well for you, and that 
> > it seems to be behaving itself over a period of days.
> 
> There seem to be still small issues, but I wasn't able to pinpoint them
> to a scenario (I'm not even 100% sure they are related to the CPU 
> scheduler, could be IO elevator or VM too). Just thought I would mention 
> them. Occassionally (very seldom, saw it two times yesterday) I have 
> visible stalls (2-3s) of my xterms. 
> It doesn't seem to be  related to direct visible background load (but i 
> wasn't able yet to get a top up during such a stall) I don't remember 
> these stalls from the non Entitlement kernel. They only happen very 
> rarely so it could be something unrelated too. I know the report is 
> probably too vague to be useful.

On the contrary, any reports of strange/bad behaviour are useful. It 
probably is related to the scheduler, as no one seems to have reported 
this problem with stock 2.6.4.

I'll look out for these stalls, and try to find the cause/fix.

John


