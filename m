Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSHIDv7>; Thu, 8 Aug 2002 23:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSHIDv7>; Thu, 8 Aug 2002 23:51:59 -0400
Received: from holomorphy.com ([66.224.33.161]:13468 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317572AbSHIDv5>;
	Thu, 8 Aug 2002 23:51:57 -0400
Date: Thu, 8 Aug 2002 20:55:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2/4) discontigmem support for i386 against 2.5.30
Message-ID: <20020809035503.GI15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Patricia Gaughen <gone@us.ibm.com>, akpm@zip.com.au,
	linux-kernel@vger.kernel.org
References: <200208090256.g792uSI05155@w-gaughen.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200208090256.g792uSI05155@w-gaughen.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 07:56:28PM -0700, Patricia Gaughen wrote:
> This patch restructures setup_arch() for i386 to make it easier to
> include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
> working on.  It also makes setup_arch() easier to read.  A version 
> of this patch is the in 2.4 aa tree.
> This patch does not depend on the other patches I'm submitting today, but 
> my discontigmem patch does depend on this one. 
> I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
> multiquad, multiquad PAE.
> Any and all feedback regarding this patch is greatly appreciated.

I've reviewed this (and the other related patches) affecting NUMA-Q
memory layout. I suppose I might be biased, but despite what others
might think, I'm really freaking impressed with how clean this stuff
is on top of the general awe factor for actually getting this stuff
going when I had trouble with it ages ago. Kudos!



Cheers,
Bill
