Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTLEKLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 05:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTLEKLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 05:11:21 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:4612 "EHLO
	diablo.hd.free.fr") by vger.kernel.org with ESMTP id S263593AbTLEKLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 05:11:19 -0500
Message-ID: <3FD059BD.1090704@free.fr>
Date: Fri, 05 Dec 2003 11:11:09 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <3FC4E8C8.4070902@free.fr> <200312041214.33376.baldrick@free.fr> <20031204085704.12d398df.rddunlap@osdl.org> <200312050838.58349.baldrick@free.fr>
In-Reply-To: <200312050838.58349.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> On Thursday 04 December 2003 17:57, Randy.Dunlap wrote:
> 
>>On Thu, 4 Dec 2003 12:14:33 +0100 Duncan Sands <baldrick@free.fr> wrote:
>>| > EIP is at releaseintf+0x62/0x80 [usbcore]
>>|
>>| I haven't found time to work on this, sorry -
>>| I'm really busy with my real jobs right now.
>>|
>>| > <0>Fatal exception: panic in 5 seconds
>>|
>>| What is this, by the way?  I never saw it.
>>
>>That comes from setting the sysctl "panic_on_oops" so that an oops
>>goes straight to a panic condition.
> 
> 
> That explains why this relatively harmless Oops was
> freezing Vince's box.  I guess he should turn it off.

Well, I don't find this oops harmless at all : my box is usually 
freezing while in a huge of other oopses that directly follow this one, 
and then nothing makes it into the logs. I had to set this sysctl once 
in order to get the first oops, but that's not related to the other 
freeze...

