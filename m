Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTLFAPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbTLFAPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:15:13 -0500
Received: from legolas.restena.lu ([158.64.1.34]:58564 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264368AbTLFAPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:15:09 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3FD1199E.2030402@gmx.de>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>
	 <3FD1199E.2030402@gmx.de>
Content-Type: text/plain
Message-Id: <1070669706.3987.4.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 01:15:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-06 at 00:49, Prakash K. Cheemplavam wrote:
> Hi,
> 
> *maybe* I found the bugger, at least I got APIC more stable (need to 
> test whether oit is really stable, compiling kernel right now...):
> 
> It is a problem with CPU disconnect function. I tried various parameters 
> in bios and turned cpu disconnect off, and tada, I could do several 
> subsequent hdparms and machine is running! As CPU disconnect is a ACPI 
> state, if I am not mistkaen, I think there is something broken in ACPI 
> right now or in APIC and cpu disconnect triggers the bug.
> 
> Maybe now my windows environment is stable, as well. It was much more 
> stable with cpu disconnect and apic, nevertheless seldomly locked up.
> 
> 
> So gals and guys, try disabling cpu disconnect in bios and see whether 
> aopic now runs stable.

> I have an Abit NF7-S Rev2.0 with Bios 2.0.

> 
> Prakash

I rebooted and checked in my BIOS, I dont seem to have "CPU Disconnect"?
Is there another name. I also downloaded the motherboard manual for your
NF7-S and cant find it there either?

Craig


