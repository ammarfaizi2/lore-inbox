Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTIIV0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTIIVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:23:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49799 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264500AbTIIVXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:23:09 -0400
Subject: Re: Determining pci bus from irq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Adam Litke <agl@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0309091322230.8129@chaos>
References: <1063123832.2037.40.camel@dyn318261bld.beaverton.ibm.com>
	 <1063127380.30397.69.camel@dhcp23.swansea.linux.org.uk>
	 <Pine.LNX.4.53.0309091322230.8129@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063142434.30981.19.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 22:20:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 18:36, Richard B. Johnson wrote:
> Unless you've got a 'scope. If a device is interrupting often
> or if it can be made to interrupt. you can look at the pin on
> the PCI card. For some reason, on ix86, the logical "pin" is
> always "A", regardless of the device, so you only have one
> interrupt line connected to each slot. On lap-tops, there is
> often only one IRQ shared for everything IRQ9 for Compaq.

Multifunction devices may well use more than INTA. A PC does 
normally use INTA for each device and barberpole the ABCD lines
between slots

Quad ethernet cards using ABCD seem common

