Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937049AbWLDQDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937049AbWLDQDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937050AbWLDQDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:03:13 -0500
Received: from s14.s14avahost.net ([66.98.146.55]:37629 "EHLO
	s14.s14avahost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937049AbWLDQDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:03:13 -0500
Message-ID: <457446AA.9050001@katalix.com>
Date: Mon, 04 Dec 2006 16:02:50 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Alessandro Zummo <alessandro.zummo@towertech.it>,
       linux-kernel@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
       eibach@gdsys.de, stieler@gdsys.de, Jean Delvare <khali@linux-fr.org>,
       Bill Gatliff <bgat@billgatliff.com>
Subject: Re: rtc-ds1307 driver (especially for DS1337, DS1339)
References: <20061202145512.3baccf92@inspiron> <200612021013.50425.david-b@pacbell.net>
In-Reply-To: <200612021013.50425.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s14.s14avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have access to my ds1337 hardware right now (working away from 
my office). Is someone else able to test this?

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development

David Brownell wrote:

> On Saturday 02 December 2006 5:55 am, Alessandro Zummo wrote:
> 
>> Hello,
>>
>> given the recent patch for ds1337 initialization (drivers/i2c/chips),
>> I would like to ask owners of DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00
>> to give a try the rtc-ds1307 driver (drivers/rtc).
>>
>> I need to be sure that it works (and correctly initializes)
>> all the chips that claims to support.
> 
> 
> Unless it's broken _recently_ we already have confirmation that rtc-1307
> works for DS1307 and M41T00, so it's the other chips that would be most
> interesting ...
> 
> 
> 
>>  Jean would be very happy if we can remove drivers from
>> i2c/chips ;)
> 
> 
> I think the ds1337.c driver could vanish if we had confirmation that
> the ds1307 driver also works on the DS1337 and DS1339 ... so, special
> thanks if you can confirm it with those chips.  Chip docs say they
> are compatible, so far as the driver is concerned.
> 
> - Dave
> 

