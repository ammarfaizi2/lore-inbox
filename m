Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTGNS72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270719AbTGNS72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:59:28 -0400
Received: from sea2-f50.sea2.hotmail.com ([207.68.165.50]:51470 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270715AbTGNS7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:59:25 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: jgarzik@pobox.com
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 12:14:13 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F50x3G5aYY61LE00011019@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 19:14:13.0942 (UTC) FILETIME=[1CDFAD60:01C34A3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does one measure the reliability and security of current software TCP/IP 
stacks?  Some standard set of test would have to be identified and the TOEs 
would need to be tested against this to ensure that they meet some minimum 
standard.  I would suggest offloading the minimum amount from the OS so that 
most of the control could be maintaind by the OS stack.  This also would 
make failover/routing changes between TOE -TOE, and TOE-NIC easier.  Current 
offloads such as checksum and segmentation will not be enough for 10GbE 
processing, so it would have to be something more than we have today.
David


>From: Jeff Garzik <jgarzik@pobox.com>
>To: David griego <dagriego@hotmail.com>
>CC: alan@storlinksemi.com,  linux-kernel@vger.kernel.org
>Subject: Re: Alan Shih: "TCP IP Offloading Interface"
>Date: Mon, 14 Jul 2003 15:02:35 -0400
>
>David griego wrote:
>>IMHO, there are several cases for some type of TCP/IP offload.  One is for 
>>embedded systems that are just not capable of doing 1Gbps+.  Another is 
>>with 10GbE, even high end servers will not be able keep up with TCP 
>>processing/data movement at these speeds.  Not being proactive in adopting 
>>TCP/IP offload will force Linux into accepting some scheme that will not 
>>necissarily be best.
>
>
>How does one evaluate a TOE stack to be sure that all the security fixes in 
>Linux are also in that stack?
>
>How does one evaluate a TOE stack to be sure it doesn't add new security 
>holes that Linux never had?
>
>	Jeff
>
>
>

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus

