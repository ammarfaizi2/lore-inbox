Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVGCEhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVGCEhe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 00:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVGCEhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 00:37:34 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54563 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261350AbVGCEh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 00:37:26 -0400
Date: Sat, 02 Jul 2005 22:37:11 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ASUS K8N-DL Beta BIOS
In-reply-to: <4lzQi-2fw-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42C76B77.9020709@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4lznf-1XY-7@gated-at.bofh.it> <4lzQi-2fw-21@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Bruno wrote:
> Also, the ACPI PCI Interrupt Routing Table (PRT) contains references to
> entries that don't exist elsewhere in the ACPI tables:
> 
> ACPI: Subsystem revision 20050309
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
> AE_NOT_FOUND
> search_node ffff81013ffca240 start_node ffff81013ffca240 return_node
> 0000000000000000
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace,
> AE_NOT_FOUND
> search_node ffff81013ffca140 start_node ffff81013ffca140 return_node
> 0000000000000000
> 
> Linux unfortunately appears to give up on parsing the PRT when this
> happens, unlike Windows, which will parse the table despite these
> errors. Without parsing the PRT, Linux cannot know how to route
> interrupts for various PCI devices, which results in the later errors:

Is there a reason Linux couldn't behave similarly to Windows in this 
situation? That might provide some better compatibility with such buggy 
BIOSes..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

