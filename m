Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVAOSCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVAOSCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 13:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVAOSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 13:02:47 -0500
Received: from smtp1.libero.it ([193.70.192.51]:29618 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261384AbVAOSCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 13:02:45 -0500
Message-ID: <41E95AC1.9080400@libero.it>
Date: Sat, 15 Jan 2005 19:02:41 +0100
From: marco <cipullo@libero.it>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
References: <200501151205.29136.cipullo@libero.it> <200501151242.31443.dtor_core@ameritech.net>
In-Reply-To: <200501151242.31443.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov ha scritto:
> On Saturday 15 January 2005 06:05 am, Marco Cipullo wrote:
> 
>>Same problem with me. I also have a laptop and I also have the same problem 
>>started in the same period.
>>
> 
> ...
> 
>>#
>># Input I/O drivers
>>#
>># CONFIG_GAMEPORT is not set
>>CONFIG_SOUND_GAMEPORT=y
>>CONFIG_SERIO=y
>>CONFIG_SERIO_I8042=m
> 
> 
> Make i8042 compiled in or make sure that your init scripts load it. Right now
> there are no traces of it in your boot log.
> 
Now it's in.....

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=m
CONFIG_SERIO_RAW=m

....but it doesn't work the same.

Bye
Marco

