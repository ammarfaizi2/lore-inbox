Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVCVRHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVCVRHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVCVRHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:07:46 -0500
Received: from ctv-217-147-43-176.init.lt ([217.147.43.176]:35513 "EHLO
	buakaw.homelinux.net") by vger.kernel.org with ESMTP
	id S261453AbVCVRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:07:29 -0500
Message-ID: <20050322190726.e1jiyi25xws0okss@buakaw.homelinux.net>
Date: Tue, 22 Mar 2005 19:07:26 +0200
From: buakaw@buakaw.homelinux.net
To: Phil Oester <kernel@linuxace.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dst cache overflow
References: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>
	<20050321194022.491060c7.akpm@osdl.org>
	<1297.192.168.0.37.1111480783.squirrel@buakaw.homelinux.net>
	<20050322161657.GA18925@linuxace.com>
In-Reply-To: <20050322161657.GA18925@linuxace.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see on 2.6.10/2.6.11.3

Quoting Phil Oester <kernel@linuxace.com>:

> On Tue, Mar 22, 2005 at 10:39:43AM +0200, buakaw@buakaw.homelinux.net wrote:
>>
>> computer's main job is to be router on small LAN with 10 users and  some
>> services like qmail, apache, proftpd, shoutcast, squid, and ices on slack
>> 10.1. Iptables and tc are used to limit  bandwiwdth and the two bandwidthd
>>  daemons are running on eth0 interface and all the time the cpu is used at
>> about 0.4% and additional 12% by ices  when encoding mp3 on demand, and
>> the proccess ksoftirqd/0 randomally starts to use 100% of 0 cpu in normal
>> situation and one time when the ksoftirqd/0 became crazy i noticed dst
>> cache overflow messages in syslog but there are more of thies lines in
>> logs  about 5 times in 10 days period
>
> There was a problem fixed in the handling of fragments which caused dst
> cache overflow in the 2.6.11-rc series.  Are you still seeing dst cache
> overflow on 2.6.11?
>
> Phil
>



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

