Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWIJTYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWIJTYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWIJTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:24:30 -0400
Received: from bbr254.neoplus.adsl.tpnet.pl ([83.27.207.254]:43929 "EHLO
	Jerry.zjeby.dyndns.org") by vger.kernel.org with ESMTP
	id S932550AbWIJTY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:24:29 -0400
Date: Sun, 10 Sep 2006 21:24:15 +0200 (CEST)
From: curious <curious@zjeby.dyndns.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: swsusp problem
In-Reply-To: <200609101133.32931.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.63.0609102123080.2685@Jerry.zjeby.dyndns.org>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
 <200609101133.32931.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Sep 2006, Rafael J. Wysocki wrote:

> Hi,
>
> On Sunday, 10 September 2006 02:13, curious wrote:
>> hello.
>> i write because swsuspend don't work for me.
>> i try to echo disk > /sys/power/state
>> and just nothing happens, i have blinking cursor and machine freezes.
>>
>> when i enabled debug i got :
>> stopping tasks: ========|
>> Shrinking memory... done (2684 pages freed)
>> swsusp: Need to copy 1454 pages
>> swsusp: critical section/: done (1454 pages copied)
>>
>> .... and machine just sits there , doing nothing.
>> after reboot it boots like usual.
>>
>> machine is Ts30M Viglen Dossier 486 SM
>> kernel is 2.6.18-rc5
>> here is config : http://zjeby.dyndns.org:8242/viglen.config
>
> Could you boot the kernel with the init=/bin/bash command line argument
> and do the following:
>
> # mount /proc
> # mount /sys
> # echo 8 > /proc/sys/kernel/printk
> # swapon -a
> # echo disk > /sys/power/state
>
> and see what happens?

same thing , except page count is different ofcourse.

