Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270792AbTGNUXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTGNUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:13:44 -0400
Received: from sea2-f51.sea2.hotmail.com ([207.68.165.51]:15624 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270764AbTGNUI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:08:27 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: jgarzik@pobox.com
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 13:23:12 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F51JQjdF8qoH2800011794@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 20:23:12.0436 (UTC) FILETIME=[BF9BBF40:01C34A45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Jeff Garzik <jgarzik@pobox.com>
>To: David griego <dagriego@hotmail.com>
>CC: alan@storlinksemi.com,  linux-kernel@vger.kernel.org
>Subject: Re: Alan Shih: "TCP IP Offloading Interface"
>Date: Mon, 14 Jul 2003 16:03:01 -0400
>
>David griego wrote:
>>Intel Clusters and Network Storage Volume Platforms Lab reported that it 
>>takes about 1MHz to process 1Mbps on a PIII.  Using this rule of thumb 
>>(they showed it scaling from 400MHz to 800MHz) it would take 10GHz to 
>>process 10Mbps.  Well you might say "what about multi-processers?"  This
>
>Um.  It doesn't take nearly 10Ghz to handle 10Mbps, or even 100Mbps.
Err.  Make that 10GHz for 10Gbps :-)
>
>
>>would be good for people that have multi-processors, but there is a large 
>>segment of embedded processors that are not going have SMP, or be at 10GHz 
>>anytime soon.  Besides that processing interrupts does not scale across 
>>MPs liniarly.  The truth is that communication speeds are outpacing 
>>processor speeds at this time.
>
>If the host CPU is a bottleneck after large-send and checksums have been 
>offloaded, then logically you aren't getting any work done _anyway_. You 
>have to interface with the net stack at some point, in which case you incur 
>a fixed cost, for socket handling, TCP exception handling, etc.
Still other processing going on like RAID, NFS, or CIFS.
>
>Maybe somebody needs to be looking into AMP (asymmetric multiprocessing), 
>too.
Nice artical on AMP for ATM.  I'll try to find a pointer.
>
>	Jeff
>
>
>

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus

