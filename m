Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWELSy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWELSy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWELSy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:54:28 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:32130 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751320AbWELSy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:54:27 -0400
Date: Fri, 12 May 2006 14:54:26 -0400
To: Krishna Chaitanya <lnxctnya@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux for Asymmetric Multi Processing Systems.
Message-ID: <20060512185426.GC2837@csclub.uwaterloo.ca>
References: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 12:24:20PM +0530, Krishna Chaitanya wrote:
> I am working on a project where the hardware is Asymmetric Multi
> Processing Systems(ASMP).
> 
> In my system I have one ARM9,  four ARM7s'.
> 
> 1. Can I use one Linux Kernel for all the CPUs in an ASMP system. (or)
>    Should I use One Linux Kernel for ARM9 and RTOSes for ARM7.
> 2. If my hardware would come up in future with another ARM7 does linux
> scale for the new CPU.
> 
> Can anyone please direct me to the source/docs how to use Linux for
> ASMP systems.

So you have two different instruction sets (although I think the arm7 is
a subset of the arm9, but what do I know), running different clocks
speeds most likely.  

Does each cpu have it's own ram, or do they all share one pool of memory?

How does the Cell processor systems deal with this?

Len Sorensen
