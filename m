Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWBXC1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWBXC1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWBXC1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:27:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15503 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932558AbWBXC1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:27:15 -0500
Date: Thu, 23 Feb 2006 21:27:01 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suppress APIC errors on UP x86-64.
Message-ID: <20060224022701.GJ23471@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014228.GB16089@redhat.com> <200602240245.30161.ak@suse.de> <20060224015322.GG23471@redhat.com> <200602240318.12239.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240318.12239.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:18:11AM +0100, Andi Kleen wrote:
 > On Friday 24 February 2006 02:53, Dave Jones wrote:
 > > On Fri, Feb 24, 2006 at 02:45:29AM +0100, Andi Kleen wrote:
 > >  > On Friday 24 February 2006 02:42, Dave Jones wrote:
 > >  > > Quite a few UP x86-64 laptops print APIC error 40's repeatedly
 > >  > > when they run an SMP kernel (And Fedora doesn't ship a UP x86-64 kernel
 > >  > > any more).  We can suppress this as there's not really anything we
 > >  > > can do about them.
 > >  > 
 > >  > No we need to fix the APIC errors, not hide them.
 > > 
 > > What do you need to fix them ?  I've got one laptop here that
 > > is affected, and there's a few other examples with dmesg's
 > > in Red Hat bugzilla that I can trawl.
 > 
 > Some pattern analysis would be useful. All the same chipset, revision?

>From first impression, it seems they're all (including mine) HP laptops
with ATI chipsets.

A quick google seems to confirm this.
http://www.google.com/search?&q=HP+%22apic+error%22

I wonder if this is related at all to the 'time goes double speed'
bug that some folks see (incidentally, I don't on mine).

 > Best you collect boot logs.

I'll try to gather some more data.

		Dave
