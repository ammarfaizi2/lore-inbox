Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTLCTlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTLCTlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:41:07 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:9661 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261967AbTLCTlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:41:05 -0500
Subject: Re: HT apparently not detected properly on 2.4.23
From: Andre Tomt <lkml@tomt.net>
To: linux-kernel@vger.kernel.org
Cc: Ethan Weinstein <lists@stinkfoot.org>
In-Reply-To: <3FCE2F8E.90104@stinkfoot.org>
References: <3FCE2F8E.90104@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1070480450.15415.85.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 20:40:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 19:46, Ethan Weinstein wrote:
> Hi,
> 
> With 2.4.22, my Supermicro X5DPL-iGM-O (E7501 chipset) with 2 
> xeons@2.4ghz and hypertherading enabled shows 4 cpu's in 
> /proc/cpuinfo|proc/interrupts, with:
> CONFIG_ACPI=y
> CONFIG_ACPI_HT_ONLY=y
> The same config with 2.4.23 only shows 2 cpus, even with:
> CONFIG_NR_CPUS=4

This may be the known problem about CONFIG_NR_CPU's not working properly
in all cases. Try up'ing it to 32.


