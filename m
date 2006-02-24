Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWBXBxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWBXBxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWBXBxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:53:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932286AbWBXBxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:53:32 -0500
Date: Thu, 23 Feb 2006 20:53:22 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suppress APIC errors on UP x86-64.
Message-ID: <20060224015322.GG23471@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014228.GB16089@redhat.com> <200602240245.30161.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240245.30161.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 02:45:29AM +0100, Andi Kleen wrote:
 > On Friday 24 February 2006 02:42, Dave Jones wrote:
 > > Quite a few UP x86-64 laptops print APIC error 40's repeatedly
 > > when they run an SMP kernel (And Fedora doesn't ship a UP x86-64 kernel
 > > any more).  We can suppress this as there's not really anything we
 > > can do about them.
 > 
 > No we need to fix the APIC errors, not hide them.

What do you need to fix them ?  I've got one laptop here that
is affected, and there's a few other examples with dmesg's
in Red Hat bugzilla that I can trawl.

		Dave

