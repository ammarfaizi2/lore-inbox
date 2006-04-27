Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWD0W0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWD0W0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWD0W0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:26:13 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:7315 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751652AbWD0W0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:26:12 -0400
Message-ID: <445144FF.4070703@cantab.net>
Date: Thu, 27 Apr 2006 23:26:07 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: IP1000 gigabit nic driver
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com>
In-Reply-To: <20060427185627.GA30871@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> David Gómez <david@pleyades.net> :
> [...]
>> Does anybody in this list know why the IP1000 driver is not
>> included in the kernel ?
> 
> Afaik the driver has never been submitted for inclusion.
> At least not on netdev@vger.kernel.org (hint, hint).
> 
> [...]
>> The card in question is:
>>
>> Sundance Technology Inc IC Plus IP1000
>>
>> and the driver can be found in sundance web, sources 
> 
> URL please ?
> 
>> included. I tried to contact the author but my email
>> bounced.
>>
>> There's no LICENSE in the source, just copyrigth
>> sentences in the .c files, so i'm not sure under
>> which license it's distributed :-?.
> 
> /me goes to http://www.icplus.com.tw/driver-pp-IP1000A.html
> 
> $ unzip -c IP1000A-Linux-driver-v2.09f.zip | grep MODULE_LICENSE
>     MODULE_LICENSE("GPL");
> 
> It's a bit bloaty but it does not seem too bad (not mergeable "as
> is" though). Do you volunteer to test random cra^W^W carefully
> engineered code on your computer to help the rework/merging process ?

I finally got around to putting a 2nd NIC in my box that has one of this 
chips and was going to start fixing the driver up and preparing it for 
submission this weekend.  Or I might try rewriting from scratch based on 
the datasheet depending on how horrific the code looks on closer inspection.

Not got a whole lot of time to do this so no timescale for completion...

David Vrabel

