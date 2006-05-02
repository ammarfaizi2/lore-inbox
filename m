Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWEBTXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWEBTXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWEBTXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:23:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33739 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750765AbWEBTXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:23:01 -0400
Date: Tue, 02 May 2006 15:23:01 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: sched_clock() uses are broken
In-reply-to: <20060502190814.GC4223@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0605021521390.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
 <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk>
 <200605021901.13882.ak@suse.de>
 <Pine.LNX.4.64.0605021316380.28543@localhost.localdomain>
 <20060502185555.GB4223@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605021503230.28543@localhost.localdomain>
 <20060502190814.GC4223@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006, Russell King wrote:

> On Tue, May 02, 2006 at 03:05:22PM -0400, Nicolas Pitre wrote:
> > If we're discussing the addition of a sched_clock_diff(), why whouldn't 
> > shed_clock() return anything it wants in that context?  It could be 
> > redefined to have a return value meaningful only to shed_clock_diff()?
> 
> If we're talking about doing that, we need to replace sched_clock()
> to ensure that we all users are aware that it has changed.
> 
> I did think about that for my original fix proposal, but stepped back
> because that's a bigger change - and is something for post-2.6.17.
> The smallest fix (suitable for -rc kernels) is as I detailed.

Oh agreed.


Nicolas
