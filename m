Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVA2Ans@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVA2Ans (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVA2Anr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:43:47 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:46552 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262825AbVA2Anq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:43:46 -0500
Message-ID: <41FADC38.4090108@drzeus.cx>
Date: Sat, 29 Jan 2005 01:43:36 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PNP and bus association
References: <41F95A42.40001@drzeus.cx> <20050128224752.GA2545@neo.rr.com>
In-Reply-To: <20050128224752.GA2545@neo.rr.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

>Hi Pierre,
>
>The platform bus does not show the actual physical relationship either.  For
>x86, ACPI is typically needed to determine this. It would be easy to bind to
>spawn pnp devices off of an ISA bridge device, attached to the pci bus, but
>whether it's the actual physical parent would be very difficult to determine
>without firmware assistance.
>
>At the moment the pnp bus is only showing a logical bus relationship.  If we
>were to use ACPI to aid in the generation of the physical device tree, we
>could put these devices in the correct physical location.
>  
>
So it is correct behaviour that the device shows up under /sys/bus/pnp 
when found using PNP, and /sys/bus/platform when scanned for?
I'm trying to get it to work well with HAL and it would be nice if it 
could be found in a consistent way.

Rgds
Pierre

