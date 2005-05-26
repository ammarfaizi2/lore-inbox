Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVEZOsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVEZOsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 10:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVEZOsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 10:48:36 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:1670 "EHLO
	mailwasher.lanl.gov") by vger.kernel.org with ESMTP id S261533AbVEZOsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 10:48:32 -0400
Message-ID: <4295E1B5.6060001@mesatop.com>
Date: Thu, 26 May 2005 08:48:21 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 0x29A (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, christoph@lameter.com
Subject: Re: 2.6.12-rc5-mm1
References: <175590000.1117089446@[10.10.2.4]>	<20050525234717.261beb48.akpm@osdl.org>	<191140000.1117091133@[10.10.2.4]>	<195320000.1117091674@[10.10.2.4]> <20050526002459.320abe65.akpm@osdl.org>
In-Reply-To: <20050526002459.320abe65.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
>>source kernel/Kconfig.hz is under:
>> menu "APM (Advanced Power Management) BIOS Support"
>> depends on PM && !X86_VISWS
>>
>> So it's screwed if you don't have PM defined, it seems.
> 
> 
> Ah, OK.  Something like this:
> 

FWIW, I had the same error as Martin, and your patch fixed it
for me on my PIII.

Steven
