Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVAEJkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVAEJkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAEJkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:40:17 -0500
Received: from webapps.arcom.com ([194.200.159.168]:23556 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262303AbVAEJkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:40:08 -0500
Message-ID: <41DBB5F6.6070801@cantab.net>
Date: Wed, 05 Jan 2005 09:40:06 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, aryix <aryix@softhome.net>,
       lug-list@lugmen.org.ar, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: dmesg: PCI interrupts are no longer routed automatically.........
References: <20041229095559.5ebfc4d4@sophia>  <1104862721.1846.49.camel@eeyore>  <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com> <1104867678.1846.80.camel@eeyore> <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2005 09:43:22.0703 (UTC) FILETIME=[FF061DF0:01C4F30A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> For instance,  Level interrupts from PLX chips on the PCI bus
> can (read do) generate interrupts when some of the BARS are
> being configured. Once you get an unhandled interrupt, you
> are dead because there's nothing to reset the line.

Why not unconditionally clear all interrupts after configuring the chip?

David Vrabel
