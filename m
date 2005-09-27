Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVI0UyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVI0UyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVI0UyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:54:23 -0400
Received: from gambit.vianw.pt ([195.22.31.34]:38292 "EHLO gambit.vianw.pt")
	by vger.kernel.org with ESMTP id S1750969AbVI0UyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:54:23 -0400
Message-ID: <4339BFA5.6070000@esoterica.pt>
Date: Tue, 27 Sep 2005 21:54:45 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour with SATA disks. Light always ON
References: <4QP2K-4ML-7@gated-at.bofh.it> <43376FD1.2020306@shaw.ca>
In-Reply-To: <43376FD1.2020306@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> Paulo da Silva wrote:
>
>> Hi!
>> I don't know if this is the right place to ask
>> about this, or even if this is a problem at all.
>>
>> Anyway I didn't find relevant information on
>> this ...
>>
>> I have just bought a new PC with two SATA drives.
>> I had no problems to have them working,
>> apparently fine except for one thing:
>> After reading the kernel, the driver access light (led?)
>> is always on!
>> Is this normal? Why?
>
>
> I don't know if this is considered "normal" but I know that the 
> Silicon Image chips do have a strange way of handling the access light 
> - it has to be specifically turned on and off by a GPIO pin in the 
> driver, the chip doesn't seem to handle it itself..
>
Is there any intention to correct this?
Should I file a bug?
I think this should be trivial for those
who know the driver ...

BTW, the kernel configuration has a specific "option" for
Silicon Image SATA, but if I choose it without "ahci"
the system does not boot! Why?

Thanks

