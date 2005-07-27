Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVG0Pe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVG0Pe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVG0PcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:32:24 -0400
Received: from pop-scotia.atl.sa.earthlink.net ([207.69.195.65]:56198 "EHLO
	pop-scotia.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262379AbVG0PbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:31:09 -0400
Message-ID: <42E7A8BA.3080406@earthlink.net>
Date: Wed, 27 Jul 2005 11:31:06 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12 sound problem
References: <42E6C8DB.4090608@earthlink.net> <1122438238.13598.19.camel@mindpipe>
In-Reply-To: <1122438238.13598.19.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2005-07-26 at 19:35 -0400, Stephen Clark wrote:
>  
>
>>Additional info I don't see any interrupts in /proc/interrupts for the
>>Allegro which is on int 5.
>>I just tried the same laptop with knoppix and a 2.4.27 kernel and sound
>>works great and I do
>>see interrupts for Allegro on int 5.
>>    
>>
>
>So the same ALSA driver works on 2.6 but fails on 2.4?  Or are you
>really saying 2.4 + the OSS driver works and 2.6 + ALSA does not?
>
>Lee
>
>  
>
Hi Lee,

Sorry for the confusion - the sound driver with kernel 2.4.27 works - it
looks like it is oss ( it is a
german knoppix cd and I don't parse german ), there is no /proc/asound
directory. Also I dont
have to provide acpi=off pci=noacpi,usepirqmask with the knoppix cd, but
I do when I boot the
2.6.12 kernel.

on 2.4.27 the kernel modules for sound are:
soundcore, ac97_codec, maestro3


so i am saying:

  2.4 + the OSS driver works and 2.6 + ALSA does not.

Thanks for the response.
Steve




