Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264426AbRFIBLS>; Fri, 8 Jun 2001 21:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264427AbRFIBLI>; Fri, 8 Jun 2001 21:11:08 -0400
Received: from james.kalifornia.com ([208.179.59.2]:42333 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S264426AbRFIBLA>; Fri, 8 Jun 2001 21:11:00 -0400
Message-ID: <3B217792.8020405@blue-labs.org>
Date: Fri, 08 Jun 2001 18:10:42 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9.1+) Gecko/20010606
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: "D. Stimits" <stimits@idcomm.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing sysrq
In-Reply-To: <Pine.LNX.4.33.0106072239570.26171-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, you ONLY need to echo 1 > /proc../sysrq if you use a distribution 
that puts a 0 there on init.

By default the kernel initializes with '1'.

David

>>>I compiled it, and the sysrq is definitely in the config. No doubt at
>>>all. I also use make mrproper and config again before dep and actual
>>>compile. Maybe it is just a quirk/oddball.
>>>
>>>D. Stimits, stimits@idcomm.com
>>>
>>Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
>>You need both, compiled in and activation.
>>


