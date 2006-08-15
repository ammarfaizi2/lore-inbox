Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWHOXFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWHOXFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHOXFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:05:36 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55620 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750804AbWHOXFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:05:35 -0400
Date: Tue, 15 Aug 2006 17:04:09 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: What determines which interrupts are shared under Linux?
In-reply-to: <fa.OQ0aZlfKc9NmI+ugRx8PT515Nks@ifi.uio.no>
To: Roger Heflin <rheflin@atipa.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-id: <44E252E9.40704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.xiop2gho7OdOydmzXzpUsR5ksXM@ifi.uio.no>
 <fa.1abHK6YDIfV51f77xhbkgnQpLwk@ifi.uio.no>
 <fa.UkMpPU+vkXMkIeBVGEpBG9C87M4@ifi.uio.no>
 <fa.9EHh5X478LQIXFY79H/n57rBfRE@ifi.uio.no>
 <fa.OQ0aZlfKc9NmI+ugRx8PT515Nks@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Heflin wrote:
> On the specific kernel that I have I appear to have both IDE and
> sata_nv drivers, is there a way to force things to use sata_nv/libata
> rather than the older ide driver for the NVIDIA sata controller?

Are you saying that drivers/ide is binding to the NVIDIA SATA 
controller? That seems odd, at least in the Fedora Core 5 kernel 
configuration, drivers/ide would never try to bind to the SATA 
controllers for me, only sata_nv would. Maybe you have some 
configuration option turned on to make drivers/ide grab anything that 
looks like an IDE controller, which probably shouldn't be turned on.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

