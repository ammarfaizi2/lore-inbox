Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTFQWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTFQWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:14:19 -0400
Received: from [62.75.136.201] ([62.75.136.201]:8578 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264960AbTFQWN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:13:59 -0400
Message-ID: <3EEF95E8.5040109@g-house.de>
Date: Wed, 18 Jun 2003 00:27:52 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71 compile error on alpha
References: <3EEE4A14.4090505@g-house.de> <wrpr85te3fa.fsf@hina.wild-wind.fr.eu.org> <3EEF585E.9030404@g-house.de> <yw1xk7bk36hw.fsf@zaphod.guide> <20030617202221.GH6353@lug-owl.de> <3EEF7B20.5030208@g-house.de> <yw1xptlcs8ng.fsf@zaphod.guide>
In-Reply-To: <yw1xptlcs8ng.fsf@zaphod.guide>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård schrieb:
>>lila:~# cat /proc/cpuinfo
[...]
>>kernel unaligned acc	: 32 (pc=fffffc0000478394,va=fffffc0002dbf176)
> 
> That's not good.  Do you know what is causing it.

i did not even know that this one is bad. the only weird thing which 
comes into my mind when thinking about this alpha is: it is filled up 
whith fine 128 MB RAM -- but it is only seeing 64 MB. when we inserted 
64 MB RAM, only 32 MB are recognized. with 32 MB working with it was no 
fun, working with 64 MB is quite good. must be the type of RAM but i 
don't really know much about the different RAM types.

> Good, what's it like performance-wise?  2.5.68 had trouble with my IDE
> disks, and I wonder if it's been fixed since.

can't tell about IDE, since it has only scsi in it. i used to run 
benchmarks (tiobench) on the alpha, with different loop-mounted 
filesystems, but the alpha has been frozen very often during these 
benchmarks...will redo with 2.5.72 later.

Thanks,
Christian.

