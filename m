Return-Path: <linux-kernel-owner+w=401wt.eu-S1750716AbWLNDBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWLNDBP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 22:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWLNDBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 22:01:15 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:63346 "EHLO
	amsfep11-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750716AbWLNDBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 22:01:14 -0500
X-Greylist: delayed 984 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 22:01:12 EST
Message-ID: <4580C8AB.9020500@science.uva.nl>
Date: Thu, 14 Dec 2006 03:44:43 +0000
From: Vasco Visser <vvisser@science.uva.nl>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
References: <20061210150730.GA6823@dreamland.darkstar.lan>
In-Reply-To: <20061210150730.GA6823@dreamland.darkstar.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tested the new driver for a couple of days, mostly by running
XDMCP session over the Gbit LAN. Its all working good.

I didn't experience any crashes or slowdowns at all. The driver is
definitly usefull in it current state.

Performance is good, tops at ~40MB/s.

BTW: what is this MSI patch?

gr,
Vasco

Luca Tettamanti wrote:
> Vasco <vvisser@science.uva.nl> ha scritto:
>   
>> I've got the p5B-E board to with the onboard attansic l1.
>>
>> I did the the atl1-2.0.2 patch against the 2.6.19.rc6 kernel.
>>     
>
> Hi,
> there has been another iteration of the driver.
>
>   
>> I can confirm the card is working but performance is *really* bad, 200Kb/s
>> over Gbit LAN.
>> I tried copying a ~50MB file over SSH and it didn't complete because of a
>> connection stall.
>>
>> I also tried turninig off TSO as adviced, but i got the message "operation
>> not supported". 
>>     
>
> Hum, did you tried:
>
> ethtool -K tso off eth0
>
> Anyway the new version of the driver keeps TSO off by default, so it
> should be fine.
> I'm attaching what I'm using here (2.0.3 + my MSI patch).
>
> Luca
>   

