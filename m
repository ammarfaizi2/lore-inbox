Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWAKCpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWAKCpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWAKCpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:45:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932648AbWAKCpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:45:54 -0500
Date: Tue, 10 Jan 2006 18:49:03 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Message-ID: <20060110184903.790d1a2c@localhost.localdomain>
In-Reply-To: <200601110227.30461.ak@suse.de>
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net>
	<200601110227.30461.ak@suse.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 02:27:30 +0100
Andi Kleen <ak@suse.de> wrote:

> On Wednesday 11 January 2006 01:54, Stephen Hemminger wrote:
> 6
> > [   37.047264] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)[   37.070722] CPU: L2 Cache: 1024K (64 bytes/line)
> > [   37.085894] mtrr: v2.0 (20020519)
> > [   37.350186] Using local APIC timer interrupts.
> > [   37.414873] Detected 12.464 MHz APIC timer.
> > [   37.428717] Booting processor 1/2 APIC 0x1
> > 
> > Machine then goes blank and reboots...
> 
> Don't know what it could be - I didn't merge anything. Maybe revert the kexec patches?
I built it without kexec and that had no change.  But perhaps it botched something.
 
> Does the -git6 snapshot still work?  Possibly do a binary search to narrow
> it down.
> 
> -Andi

