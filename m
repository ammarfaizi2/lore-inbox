Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUGDOk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUGDOk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 10:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUGDOk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 10:40:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57018 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265706AbUGDOkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 10:40:25 -0400
Date: Sun, 4 Jul 2004 11:13:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Zack Brown <zbrown@tumblerings.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems getting SMP to work with vanilla 2.4.26
Message-ID: <20040704141336.GA18851@logos.cnet>
References: <20040704020543.GA1776@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704020543.GA1776@tumblerings.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 07:05:43PM -0700, Zack Brown wrote:
> Hi folks,
> 
> When booting vanilla 2.4.26 with SMP enabled, I get a lockup before the
> boot sequence is completed. The same kernel with SMP disabled boots and runs
> just fine. Both CPUs are detected by the system at bootup, before lilo takes
> over. Here's the error as I wrote it down from the screen, followed by the
> .config file:
> 
> ------------------------------ cut here ------------------------------
> Using local APIC timer interrupts.
> Calibrating APIC timer...
> ..... CPU clock speed is 1004.4785 MHZ
> ..... hostbus clock speed is 133.9304 MHz
> cpu: 0, clocks: 1339304, slice: 446434
> CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> cpu: 1, clocks: 1339304, slice: 446434
> CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> ------------------------------ cut here ------------------------------
> 
> At that point the machine just hangs, with no keys recognized, and I have
> to power-cycle the machine in order to boot to a UP kernel.
> 
> I'd appreciate any help I can get with this.

I can't help much really. Tried CONFIG_ACPI_BOOT=n ? 

