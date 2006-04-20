Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWDTNLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWDTNLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWDTNLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:11:44 -0400
Received: from dobermann.cosy.sbg.ac.at ([141.201.2.56]:44967 "EHLO
	dobermann.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id S1750916AbWDTNLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:11:42 -0400
Message-ID: <444774F3.8000200@cosy.sbg.ac.at>
Date: Thu, 20 Apr 2006 13:48:03 +0200
From: Christian Praehauser <cpraehaus@cosy.sbg.ac.at>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb-core: ULE fixes and RFC4326 additions (kernel 2.6.16)
References: <44465208.5030004@cosy.sbg.ac.at>	<20060419235349.2b1840c0.akpm@osdl.org>	<44475DDD.1020206@cosy.sbg.ac.at> <20060420032655.475e15ed.akpm@osdl.org>
In-Reply-To: <20060420032655.475e15ed.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>After correcting the broadcast address i saw that broadcast packets are 
>> not accepted when in "multicast" mode (RX_MODE_MULTI).
>> In the attached version of the patch this was fixed.
>>    
>>
>
>This driver would have to be one of the ugliest-looking things in the
>kernel.  You must have a strong stomach.
>
>  
>
Well, yes ;-).
I agree with you, but i did not have the time and the courage to redo 
the whole thing.
The original goal was to fix the support for ULE extension headers (e.g. 
for link layer security, FEC, etc.),
which is broken in the current kernel versions.

I would welcome a discussion for beautifying the dvb-core (especially 
dvb_net.c) module.

>> --- drivers/media/dvb/dvb-core/dvb_net.c.orig	2006-04-19 15:12:31.000000000 +0200
>> +++ drivers/media/dvb/dvb-core/dvb_net.c	2006-04-20 11:04:18.000000000 +0200
>>    
>>
>
>Please prepare future patches in `patch -p1' form:
>
>--- a/drivers/media/dvb/dvb-core/dvb_net.c
>+++ a/drivers/media/dvb/dvb-core/dvb_net.c
>  
>
Thanks for the hint. Will do so in future patches.

Have a nice day!
Christian.

-- 
________________________________________
| Christian Praehauser                  |
|---------------------------------------|
| Email:                                |
|  cpraehaus@cosy.sbg.ac.at             |
| Address:                              |
|  Institut fuer Computerwissenschaften | 
|  Jakob-Haringer-Strasse 2             |
|  A-5020 Salzburg, Austria             |
|_______________________________________|

