Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTLCWkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTLCWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:40:35 -0500
Received: from holomorphy.com ([199.26.172.102]:65230 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262116AbTLCWk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:40:29 -0500
Date: Wed, 3 Dec 2003 14:40:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HT apparently not detected properly on 2.4.23
Message-ID: <20031203224023.GV8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org
References: <3FCE2F8E.90104@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE2F8E.90104@stinkfoot.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 01:46:38PM -0500, Ethan Weinstein wrote:
> With 2.4.22, my Supermicro X5DPL-iGM-O (E7501 chipset) with 2 
> xeons@2.4ghz and hypertherading enabled shows 4 cpu's in 
> /proc/cpuinfo|proc/interrupts, with:
> CONFIG_ACPI=y
> CONFIG_ACPI_HT_ONLY=y
> The same config with 2.4.23 only shows 2 cpus, even with:
> CONFIG_NR_CPUS=4
> Also, I believe this has been reported before, but the system only seems 
> to interrupt on CPU0 with either kernel, unless I apply a patch I found 
> here:
> http://www.hardrock.org/kernel/2.4.22/irqbalance-2.4.22-MRC.patch
> or run the `irqbalance' program.. which I don't care to do.  This 
> problem _seems_ to be isolated to the Supermicro, as HT does seem 
> properly detected on several other SMP systems I have at work (compaq 
> ML370/ML380) with 2.4.23

You probably have sparse physical APIC ID's.


-- wli
