Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUKOOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUKOOvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKOOtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:49:43 -0500
Received: from ip126.globalintech.pl ([62.89.81.126]:7940 "EHLO
	MAILSERVER.dmz.globalintech.pl") by vger.kernel.org with ESMTP
	id S261616AbUKOOsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:48:05 -0500
Message-ID: <4198C1A4.8080707@globalintech.pl>
Date: Mon, 15 Nov 2004 15:48:04 +0100
From: Blizbor <kernel@globalintech.pl>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6 native IPsec implementation question
References: <4198B2B6.9050803@globalintech.pl> <Pine.LNX.4.53.0411151455020.17543@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411151455020.17543@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2004 14:48:04.0205 (UTC) FILETIME=[1C94B1D0:01C4CB22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

;) My question wasn't "how does ipsec rules looks" but "why its 
implemented such a way".
These almost exactly are rules I want to implement.
But, when you run tcpdump -nni eth0 you can see ESP traffic _and_ one 
direction of something going through IPsec.
Imagine, that on eth0 five IPsec tunnels are "ended" and only one I wish 
to allow tcp/389.
It seems not possible to just allow tcp/389 from only one VPN because IP 
addresses are changing daily
in all 5 remote locations.
Moreover "-i eth0 -j DROP" blocks IPsec traffic ... (or -o eth0 i don't 
remember direction)


Jan Engelhardt wrote:

>>2. Why IPsec in 2.6 doesn't creates entries in the route tables ?
>>    
>>
>
>Because it doesnot create a device ipsecN?
>  
>
And thats the issue - WHY it is implemented such a way ?
Which developement considerations caused that choice ?

Regards,
Blizbor

