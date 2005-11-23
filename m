Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVKWUaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVKWUaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKWUaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:30:03 -0500
Received: from mail.suse.de ([195.135.220.2]:34190 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932364AbVKWU3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:29:33 -0500
Date: Wed, 23 Nov 2005 21:29:32 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yinghailu@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Ronald G Minnich <rminnich@lanl.gov>,
       discuss@x86-64.org, linuxbios@openbios.org,
       linux-kernel@vger.kernel.org, yhlu <yhlu.kernel@gmail.com>
Subject: Re: [discuss] Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123202932.GP20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <20051123173504.GK20775@brahms.suse.de> <2ea3fae10511230943y5f697eb8sdbf891497fa8b88f@mail.gmail.com> <20051123175042.GM20775@brahms.suse.de> <2ea3fae10511231001r47fcfa64r8afa8bd5552479d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae10511231001r47fcfa64r8afa8bd5552479d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:01:51AM -0800, yhlu wrote:
> NB_CFG bit 54 for E0 stepping later can be set.

That MSR is not even in my docs. Sounds very stepping specific.
Probably nothing that a kernel should access. The k8topology
code is already far too machine specific and making it more
so would be a mistake.

-Andi
