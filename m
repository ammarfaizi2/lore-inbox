Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUGQVX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUGQVX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 17:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUGQVX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 17:23:56 -0400
Received: from mail3.absamail.co.za ([196.35.40.69]:17471 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S261951AbUGQVXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 17:23:55 -0400
Subject: Re: [2.6.7-mm5 ACPI] Error: Looking up [SERN] in namespace
From: Niel Lambrechts <antispam@absamail.co.za>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1089931816.9446.19.camel@ksyrium.local>
References: <1089931816.9446.19.camel@ksyrium.local>
Content-Type: text/plain
Message-Id: <1090099462.5970.1.camel@ksyrium.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Jul 2004 23:24:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 00:50, Niel Lambrechts wrote:
> Hi,
> 
> I get the following (repetitive) dmesg on my Thinkpad R50P:
> 
>  dswload-0292: *** Error: Looking up [SERN] in namespace, AE_ALREADY_EXISTS
>  psparse-0597 [86051] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
>  psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c1567fa8), AE_ALREADY_EXISTS
>      osl-0899 [86055] os_wait_semaphore     : Failed to acquire semaphore[dff5e580|1|0], AE_TIME
>  dswload-0641: *** Error: Looking up [SERN] in namespace, AE_NOT_FOUND
>  psparse-0597 [86064] ps_parse_loop         : During name lookup/catalog, AE_NOT_FOUND
>  psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c1567fa8), AE_NOT_FOUND
>  psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c1567928), AE_NOT_FOUND
> acpi_battery-0146 [86057] acpi_battery_get_info : Error evaluating _BIF
>      osl-0899 [87427] os_wait_semaphore     : Failed to acquire semaphore[dff5e580|1|0], AE_TIME
>      osl-0899 [95484] os_wait_semaphore     : Failed to acquire semaphore[dff5e580|1|0], AE_TIME
>      osl-0899 [96766] os_wait_semaphore     : Failed to acquire semaphore[dff5e580|1|0], AE_TIME
>      osl-0899 [98886] os_wait_semaphore     : Failed to acquire semaphore[dff5e580|1|0], AE_TIME
>      osl-0899 [101057] os_wait_semaphore     : Failed to acquire semaphore[dff5e580|1|0], AE_TIME
> 
> The last line is especially repetitive.
> 
> I also notice:
> acpi_battery-0146 [86057] acpi_battery_get_info : Error evaluating _BIF

My fault - failed to do a make clean after replacing the previous version of my dsdt table and recompiling the kernel.


