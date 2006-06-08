Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWFHAXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWFHAXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWFHAXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:23:22 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:17308
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932475AbWFHAXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:23:21 -0400
Message-ID: <44876DF9.3070205@microgate.com>
Date: Wed, 07 Jun 2006 19:23:21 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com> <Pine.LNX.4.64.0606080044350.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606080044350.17704@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Wed, 7 Jun 2006, Paul Fulghum wrote:
> 
> 
>>-#ifdef CONFIG_HDLC_MODULE
>>+#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE)
>> #define CONFIG_HDLC 1
>> #endif
> 
> 
> Please don't define your own config symbols, just use Kconfig for this, 
> simply remove the prompts from your earlier patch and add the dependecies 
> as Randy suggested.

Randy's patch defines config symbols, so I don't know what you are getting at.

--
Paul

