Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVHWJo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVHWJo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVHWJo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:44:58 -0400
Received: from smtp2.netcologne.de ([194.8.194.218]:21459 "EHLO
	smtp2.netcologne.de") by vger.kernel.org with ESMTP id S932114AbVHWJo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:44:58 -0400
Message-ID: <430AF072.2060908@mch.one.pl>
Date: Tue, 23 Aug 2005 11:46:26 +0200
From: Tomasz Chmielewski <mangoo@mch.one.pl>
User-Agent: Mozilla Thunderbird 1.0.6-3mdk (X11/20050322)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: mass "tulip_stop_rxtx() failed", network stops
References: <430AE85E.5040002@mch.one.pl> <5a2cf1f6050823023741682524@mail.gmail.com>
In-Reply-To: <5a2cf1f6050823023741682524@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste schrieb:
> On 8/23/05, Tomasz Chmielewski <mangoo@mch.one.pl> wrote:
> 
>>We are running almost 20 Fujitsu-Siemens Scenic machines, 2.6.8.1
>>kernel, equipped with a onboard card that uses a tulip module:
>>
>>02:01.0 Ethernet controller: Linksys NC100 Network Everywhere Fast
>>Ethernet 10/100 (rev 11)
>>
>>No problem with those.
>>
>>
>>We are running four more machines like that, the only difference is the
>>kernel they are running (2.6.11.4).
>>
>>On some of them, there are serious problems with a network, and they
>>usually happen when the traffic is bigger than usual (i.e., some big
>>software deployment to several workstations, remote backup, etc.).
>>
>>The syslog is then full of entries like that:
>>
>>Aug 21 04:04:30 SERVER-B-HS kernel: NETDEV WATCHDOG: eth0: transmit
>>timed out
>>Aug 21 04:04:30 SERVER-B-HS kernel: 0000:00:06.0: tulip_stop_rxtx() failed
> 
> 
> I am seeing thousands of tulip_stop_rxtx() failed messages as well
> with 2.6.11. No regular network failure though.
> 
> See http://kerneltrap.org/mailarchive/1/message/110291/flat

Lucky you.
Really no network problems, no increased ping responses?
For me lots of pings are lost, and when this "tulip_stop_rxtx() failed" 
happens, the time for a ping to "go back" can be as big as 14 seconds in 
a 100 Mbit LAN.



-- 
Tomek
http://wpkg.org
