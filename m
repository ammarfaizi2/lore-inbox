Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSKHSbJ>; Fri, 8 Nov 2002 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSKHSbJ>; Fri, 8 Nov 2002 13:31:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63496 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261934AbSKHSbH>; Fri, 8 Nov 2002 13:31:07 -0500
Message-ID: <3DCC0474.6010906@zytor.com>
Date: Fri, 08 Nov 2002 10:37:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.4.20-rc1: oops in drivers/acpi/namespace/nswalk.c (with pat
 ch)
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4D7@orsmsx119.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
>>From: H. Peter Anvin [mailto:hpa@zytor.com] 
> 
> 
>>I have one machine which has been reliably oopsing in 
>>drivers/acpi/namespace/nswalk.c -- this patch makes it work, 
>>but I have 
>>no idea why.  Either way, I thought someone would probably 
>>want to look 
>>at it.
> 
> 
> Is this reproducible in 2.5.latest? If not, then it's fixed in the 2.4 ACPI
> patch and is just awaiting merge.
> 

I don't know.

In fact, I have found that apparently there is a worse ACPI regression 
between 2.4.20-pre5 and 2.4.20-rc1; I have one machine here which does 
not work without ACPI (because of broken PCI tables -- that's what you 
get for duplicating data), and -pre5 works on it and -rc1 doesn't.

I will try 2.5.<latest> when I get home this evening.

	-hpa


