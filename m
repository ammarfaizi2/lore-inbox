Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVKWRuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVKWRuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVKWRuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:50:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:1414 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932117AbVKWRuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:50:44 -0500
Date: Wed, 23 Nov 2005 18:50:42 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yinghailu@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Ronald G Minnich <rminnich@lanl.gov>,
       discuss@x86-64.org, linuxbios@openbios.org,
       linux-kernel@vger.kernel.org, yhlu <yhlu.kernel@gmail.com>
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123175042.GM20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <20051123173504.GK20775@brahms.suse.de> <2ea3fae10511230943y5f697eb8sdbf891497fa8b88f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae10511230943y5f697eb8sdbf891497fa8b88f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:43:12AM -0800, yhlu wrote:
> fallback code it not needed, because for AMD optern, at that point you can
> figure out the node id and core id from initial apic id exactly....

AFAIK there is no foolproof way to figure out the HT node id from the
initial APIC ID. One is in the Northbridge, the other is in CPUID,
but there is no directly visible connection. 

If you know one please share it

-Andi
