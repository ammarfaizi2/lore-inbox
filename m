Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVLFCOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVLFCOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVLFCOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:14:00 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:50045 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964923AbVLFCN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:13:59 -0500
Date: Mon, 05 Dec 2005 20:13:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: APIC,  x86: How to change the IRQ of one board when BIOS can't ?
In-reply-to: <5gkZk-1Nw-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4394F3DA.6040300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5gkZk-1Nw-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> Hi,
> 
> I get sometimes an APIC error on CPU 1. for IRQ 169, I get 4 modules : 3 USB 
> and one Nvidia ( I know, you dislike that). I would like to affect another 
> IRQ to the nvidia card to see if the problem is nvidia or not. I don't want 
> to modify the others IRQ.
> I can't from the BIOS. I red Documentation/i386/IO-APIC.txt but I'm not sure 
> it is possible.
> What is the best method to do that ? is pirq the solution ? how ?

If the BIOS can't do it, it may not be possible at all, i.e. the 
interrupt lines may be hard wired that way on the motherboard.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

