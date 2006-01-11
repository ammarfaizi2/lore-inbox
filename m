Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWAKBpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWAKBpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWAKBpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:45:34 -0500
Received: from ns2.suse.de ([195.135.220.15]:39357 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161057AbWAKBpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:45:33 -0500
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Date: Wed, 11 Jan 2006 02:27:30 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net>
In-Reply-To: <20060110165457.42ed2087@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601110227.30461.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 01:54, Stephen Hemminger wrote:
6
> [   37.047264] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)[   37.070722] CPU: L2 Cache: 1024K (64 bytes/line)
> [   37.085894] mtrr: v2.0 (20020519)
> [   37.350186] Using local APIC timer interrupts.
> [   37.414873] Detected 12.464 MHz APIC timer.
> [   37.428717] Booting processor 1/2 APIC 0x1
> 
> Machine then goes blank and reboots...

Don't know what it could be - I didn't merge anything. Maybe revert the kexec patches? 
Does the -git6 snapshot still work?  Possibly do a binary search to narrow
it down.

-Andi
