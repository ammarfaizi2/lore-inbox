Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUJ3NA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUJ3NA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUJ3NAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:00:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:63959 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261160AbUJ3NAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:00:05 -0400
Date: Sat, 30 Oct 2004 14:56:04 +0200
From: Andi Kleen <ak@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] x86-64: fix sibling map again!
Message-ID: <20041030125604.GF14735@wotan.suse.de>
References: <20041029170215.A26372@unix-os.sc.intel.com> <200410291735.32175.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291735.32175.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 05:35:32PM -0700, James Cleverdon wrote:
> Hey Suresh,
> 
> Can you tell me why Intel considers cpuid to be The One True
> Way(TM) to get sibling info?  Especially on x86-64, which
> doesn't have the same level of APIC weirdness that i386 does.
> 
> (I won't even mention the fact that someone messed up on the
> MSR the BIOS can use to set bits 7:5 in the cpuid ID value.
> It should allow the BIOS to set bits 7:3.)

I have no great opinion on either ways, but I suppose
it is best to do the same thing as i386 and apply Suresh's patch.

James, any strong objections? 

-Andi

