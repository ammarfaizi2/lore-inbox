Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWEYTWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWEYTWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWEYTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:22:20 -0400
Received: from hera.kernel.org ([140.211.167.34]:57830 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030328AbWEYTWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:22:19 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: b44 driver issues?
Date: Thu, 25 May 2006 12:21:54 -0700
Organization: OSDL
Message-ID: <20060525122154.3270e4bd@localhost.localdomain>
References: <200605251919.00614.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1148584911 3260 10.8.0.54 (25 May 2006 19:21:51 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 25 May 2006 19:21:51 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006 19:19:00 +0100
David Johnson <dj@david-web.co.uk> wrote:

> Hi all,
> 
> I have a Dell Inspiron 5150 laptop with a Broadcom BCM4401 network card which 
> uses the b44 driver.
> 
> With recent kernels (I've tested with Ubuntu's 2.6.15,  vanilla 2.6.16.18 and 
> 2.6.17-rc5) the driver loads without error but the interface isn't 
> registered.
> 
> In dmesg:
> b44.c:v1.00 (Apr 7, 2006)
> ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 177
> eth0: Broadcom 4400 10/100BaseT Ethernet 00:11:43:7b:69:ae
> 
> # ifconfig eth0
> eth0: error fetching interface information: Device not found

Did a hotplug script rename it for you.

# ifconfig -a
