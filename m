Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWBXCST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWBXCST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBXCST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:18:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:6036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932516AbWBXCSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:18:18 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Suppress APIC errors on UP x86-64.
Date: Fri, 24 Feb 2006 03:18:11 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014228.GB16089@redhat.com> <200602240245.30161.ak@suse.de> <20060224015322.GG23471@redhat.com>
In-Reply-To: <20060224015322.GG23471@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240318.12239.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 02:53, Dave Jones wrote:
> On Fri, Feb 24, 2006 at 02:45:29AM +0100, Andi Kleen wrote:
>  > On Friday 24 February 2006 02:42, Dave Jones wrote:
>  > > Quite a few UP x86-64 laptops print APIC error 40's repeatedly
>  > > when they run an SMP kernel (And Fedora doesn't ship a UP x86-64 kernel
>  > > any more).  We can suppress this as there's not really anything we
>  > > can do about them.
>  > 
>  > No we need to fix the APIC errors, not hide them.
> 
> What do you need to fix them ?  I've got one laptop here that
> is affected, and there's a few other examples with dmesg's
> in Red Hat bugzilla that I can trawl.

Some pattern analysis would be useful. All the same chipset, revision?

Best you collect boot logs.

-Andi
