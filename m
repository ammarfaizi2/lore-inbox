Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTLOChw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 21:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTLOChw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 21:37:52 -0500
Received: from [202.37.96.11] ([202.37.96.11]:30694 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S263205AbTLOChv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 21:37:51 -0500
Date: Mon, 15 Dec 2003 15:38:44 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Re: How to send an IP packet from the kernel
In-reply-to: <Pine.LNX.4.44.0312142130380.22128-100000@sparrow>
To: William Stearns <wstearns@pobox.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3FDD1EB4.3020305@tait.co.nz>
Organization: Tait Electronics Ltd
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
References: <Pine.LNX.4.44.0312142130380.22128-100000@sparrow>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I have a dstaddr, srcaddr and the actual data(payload). I need to load 
>>IP packet with data(payload) and send the packet out to the net through 
>>eth0 .
>>How do I do this from the kernel?
>>    
>>
>
>	Why not do it from userspace, with lots of available tools ( 
>http://www.stearns.org/doc/pcap-apps.html , 
>http://www.stearns.org/netreply )?
>  
>
For reasons that the driver will do extra stuff on this data and this 
data not always will be/must be available to a user space app.
Some data will be available only inside of the driver. No other 
processing out of the driver for that data is allowed.

