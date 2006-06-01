Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWFAXhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWFAXhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFAXhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:37:10 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27974 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750958AbWFAXhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:37:08 -0400
Date: Thu, 01 Jun 2006 17:37:01 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-reply-to: <6iYQx-5Jc-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Message-id: <447F7A1D.3070906@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6iYGP-5hv-3@gated-at.bofh.it> <6iYQx-5Jc-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
>>
>> (Goes away and pats all his 240V plugpacks which are happily working off 110V).
> 
> They probably will.  The question is, how far out-of-spec should the 
> kernel allow by default?  200% is likely to be too far (your plugpacks 
> notwithstanding).

I would say by default the kernel should not allow any out-of-spec power 
condition. Some devices might decide to go into over-current mode if a 
device draws too much power, taking down other devices on the USB bus. 
This sort of behavior should only be enabled if the user explicitly 
chooses to live dangerously.

Especially given the fact that Windows enforces the USB power supply 
limits strictly, and that's where all the hardware is best tested..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

