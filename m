Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbVKZFmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbVKZFmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 00:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVKZFmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 00:42:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:32235 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932725AbVKZFmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 00:42:16 -0500
Date: Fri, 25 Nov 2005 15:34:52 -0800
From: Greg KH <greg@kroah.com>
To: Manuel Hartl <mhartl@hartl-it.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB module crash
Message-ID: <20051125233452.GA28617@kroah.com>
References: <4386C2DA.6070002@hartl-it.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4386C2DA.6070002@hartl-it.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 08:52:58AM +0100, Manuel Hartl wrote:
> hi list,
> 
> last night (i think again) usb module(s) crashed. the running usb 
> devices are a avm fritz usb dsl 2 and a usb mouse. i do not think this 
> is avm related (cdslusb2 module), maybe an acpi/power management error?
> 
> please loook at the included stack trace.
> can someone tell me (by looking at the trace), what could be the problem 
> here?
> 
> hardware:
> asus a8v deluxe (via k8t800 chipset) / socket 939 / amd64 3000+
> cool and quiet was active in bios, but no module was loaded 
> (powernow_k8), acpi/apic is enabled.
> 
> 
> 
> Nov 25 02:26:40 media kernel:  [<c029b1ec>] kref_get+0x3c/0x40

Are you _sure_ this is an oops, and not just a kernel warning?

Can you provide the whole message that the kernel spit out?

And if this is not for a driver that is in the kernel tree, it's a bit
hard for us to help you out here, try asking the authors of the driver
itself, as that is the code that is causing problems here.

good luck,

greg k-h
