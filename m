Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753917AbWKGBdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbWKGBdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbWKGBdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:33:39 -0500
Received: from ambassador.mathewson.co.uk ([82.70.12.54]:51084 "EHLO
	envoy.mathewson.co.uk") by vger.kernel.org with ESMTP
	id S1753917AbWKGBdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:33:39 -0500
Message-ID: <454FE271.8020201@mathewson.co.uk>
Date: Tue, 07 Nov 2006 01:33:37 +0000
From: Joseph Mathewson <joe@mathewson.co.uk>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange PCI behaviour on Via K8M800CE chipset Shuttle & sata
 fails with noapic
References: <454FD8B2.5070702@mathewson.co.uk> <1162863146.11073.39.camel@localhost.localdomain>
In-Reply-To: <1162863146.11073.39.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-11-07 am 00:52 +0000, ysgrifennodd Joseph Mathewson:
>   
>> 2) Appear in lspci but not appear in /proc/interrupts.  Loading the 
>> driver will result in no card found.  No interface.
>>     
>
> In this case does lspci show different values particularly of device or
> vendor id. If so you've got a dodgy PCI connector or link somewhere.
>
>   
No, lspci shows _correct_ values.  With the single NIC, it will show the 
correct device/vendor ID of the NIC. With the multi-port NIC/bridge, it 
will show just the Intel bridge (correctly) and not the devices behind 
it.  It's like it knows it is there but can't talk to it.

Joe.
