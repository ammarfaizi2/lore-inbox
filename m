Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVGRPq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVGRPq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVGRPq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:46:27 -0400
Received: from relay02.pair.com ([209.68.5.16]:14343 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261469AbVGRPq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:46:26 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42DBCECF.9050005@cybsft.com>
Date: Mon, 18 Jul 2005 10:46:23 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Wiese <annabellesgarden@yahoo.de>
CC: Ingo Molnar <mingo@elte.hu>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507141450.42837.annabellesgarden@yahoo.de> <20050716171537.GB16235@elte.hu> <200507171407.20373.annabellesgarden@yahoo.de>
In-Reply-To: <200507171407.20373.annabellesgarden@yahoo.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese wrote:
> Am Samstag, 16. Juli 2005 19:15 schrieb Ingo Molnar:
> 
>>* Karsten Wiese <annabellesgarden@yahoo.de> wrote:
>>
>>
>>>Have I corrected the other path of ioapic early initialization, which 
>>>had lacked virtual-address setup before ioapic_data[ioapic] was to be 
>>>filled in -51-28? Please test attached patch on top of -51-29 or 
>>>later. Also on Systems that liked -51-28.
>>
>>thanks - i've applied it to my tree and have released the -51-31 patch.  
>>It looks good on my testboxes.
>>
> 
> Found another error:
> the ioapic cache isn't fully initialized in -51-31's ioapic_cache_init().
> Please apply attached patch on top of -51-31.
> 
>     Karsten
> 

I have this successfully booted on both of my SMP boxes now.

-- 
    kr
