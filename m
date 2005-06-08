Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFHNvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFHNvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFHNvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:51:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22914 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261235AbVFHNvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:51:44 -0400
Date: Wed, 8 Jun 2005 15:51:38 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050608135138.GX23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506051015.33723.kernel-stuff@comcast.net> <20050606092925.GA23831@wotan.suse.de> <200506060746.23047.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506060746.23047.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 07:46:22AM -0400, Parag Warudkar wrote:
> On Monday 06 June 2005 05:29, Andi Kleen wrote:
> > And does it work with nopmtimer ?
> >
> > -Andi
> 
> Thanks for trimming the CC list. 
> 
> No it doesn't work with nopmtimer - music still plays fast. I have to go back 
> to 2.6.11 to get it to play at right speed. 

Then it is something else, not the pmtimer.

I dont know what it could be. Do a binary search? 

-Andi

> 
> Relevant lines from rc5 with nopmtimer -
> 
> Jun  6 07:11:59 tux-gentoo [    0.000000] time.c: Using 1.193182 MHz PIT 
> timer.
> Jun  6 07:11:59 tux-gentoo [    0.000000] time.c: Detected 797.952 MHz 
> processor.
> Jun  6 07:11:59 tux-gentoo [   22.152032] time.c: Using PIT/TSC based 
> timekeeping.
> 
> 
> Parag
