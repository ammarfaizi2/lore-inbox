Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266363AbUFQEOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266363AbUFQEOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 00:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUFQEOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 00:14:55 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:7136 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S266363AbUFQEOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 00:14:54 -0400
Message-ID: <40D11AC9.3060009@backtobasicsmgmt.com>
Date: Wed, 16 Jun 2004 21:15:05 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7 - ACPI still broken
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <1087407777.2959.12.camel@forum-beta.geizhals.at>
In-Reply-To: <1087407777.2959.12.camel@forum-beta.geizhals.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer wrote:

> As posted on 2004-06-07 ACPI support seems to be broken for Intel
> D865PERL board since at least 2.6.7-rc2.
> 
> When booting with the standard flags (nmi_watchdog=1 root=/dev/md0
> video=matroxfb:vesa:0x1bb) the kernel locks up with different error
> messages immediately after "ACPI: Subsystem revision 20040326". Adding
> "acpi=off" to the command line makes everything work again.

I have the same problem, using a D865GBF, which is nearly the same 
board. BIOS is the most current version; booting with acpi=off allows 
the boot to proceed and function normally. I've tried rebuilding without 
"kernel IRQ balancing" and "register parameters" (which were my two most 
recent config changes), but no improvement.
