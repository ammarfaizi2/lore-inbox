Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTLFDKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 22:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTLFDKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 22:10:14 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:62684 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S264943AbTLFDKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 22:10:11 -0500
Date: Fri, 5 Dec 2003 20:20:42 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031206032042.GA248@tesore.local>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com> <20031205201812.GA10538@localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205201812.GA10538@localnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 09:18:12PM +0100, cheuche+lkml@free.fr wrote:
> On Fri, Dec 05, 2003 at 11:11:39AM -0800, Allen Martin wrote:
> With a little patch in arch/i386/kernel/mpparse.c in the acpi section, I
> managed to get the timer interrupt back on IO-APIC-edge, maybe the nmi
> watchdog could work with the ioapic then ?
> 


Like reported, with the patch the timer uses IO-APIC-edge, and the noise on IRQ 7 is gone, but still unable to catch a lockup with nmi_watchdog.

=(

Jesse
