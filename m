Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTLEKem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 05:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTLEKem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 05:34:42 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:6916 "EHLO
	diablo.hd.free.fr") by vger.kernel.org with ESMTP id S263595AbTLEKek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 05:34:40 -0500
Message-ID: <3FD05F3A.2000703@free.fr>
Date: Fri, 05 Dec 2003 11:34:34 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <3FC4E8C8.4070902@free.fr> <200312050838.58349.baldrick@free.fr> <3FD059BD.1090704@free.fr> <200312051118.37232.baldrick@free.fr>
In-Reply-To: <200312051118.37232.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
>>>That explains why this relatively harmless Oops was
>>>freezing Vince's box.  I guess he should turn it off.
>>
>>Well, I don't find this oops harmless at all : my box is usually
>>freezing while in a huge number of other oopses that directly follow this one,
>>and then nothing makes it into the logs. I had to set this sysctl once
>>in order to get the first oops, but that's not related to the other
>>freeze...
> 
> 
> What is the second Oops?

No idea... without the sysctl, the screen keeps scrolling printing new 
oopes (49 of them in my last attempt), in which case nothing about it 
ever reaches the disk log (and it looks like the kernel buffer is too 
short when using kmsgdump).
  Could it be possible to have something like:
echo 2 > /proc/sys/kernel/panic_on_oops
...and have the system panic at the 2nd oops ?

