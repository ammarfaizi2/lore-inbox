Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVHCTWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVHCTWC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVHCTV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:21:57 -0400
Received: from dsw2k3.info ([195.71.86.227]:16328 "EHLO dsw2k3.info")
	by vger.kernel.org with ESMTP id S262440AbVHCTVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:21:31 -0400
Message-ID: <42F11933.7050607@citd.de>
Date: Wed, 03 Aug 2005 21:21:23 +0200
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Subject: Re: ahci, SActive flag, and the HD activity LED
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> Jens Axboe wrote:
> 
>>> If I am reading the specs correctly, that'd mean the ahci driver is 
>>> wrong in setting the SActive bit.
>>
>>
>> I completely agree, that was my reading of the spec as well and hence my
>> original posts about this in the NCQ thread.
> 
> Have you (or has anybody else) also seen the wrong behavior of the 
> activity LED?

925X-Chipset
Lspci says: 8086:2652
Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03)
HDD:
Western Digital WD2000JD-00H, i believe this HDD is non-NCQ.

Kernels: 2.6.10 - 2.6.12
The Activity-LED has burned like a light-bulb every since i have that 
computer. (Excluding the few seconds before booting Linux. :-) )



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

