Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUDHWZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUDHWZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:25:55 -0400
Received: from puppen.tomt.net ([217.8.136.222]:62631 "EHLO puppen.tomt.net")
	by vger.kernel.org with ESMTP id S262873AbUDHWZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:25:25 -0400
Message-ID: <4075D155.2030603@tomt.net>
Date: Fri, 09 Apr 2004 00:25:25 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Does OSS sound work in 2.6 or not?
References: <4075BDE0.6050302@tmr.com>
In-Reply-To: <4075BDE0.6050302@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I have several user machines I would like to convert to 2.6 because they 
> run threaded applications and would be happier if I did. However, being 
> able to play forwarded wav files is also needed. I have been assurred by 
> several people in Email that it does, *without* converting the whole 
> machine from OSS to ALSA, but by running the ALSA+OSS emulation.
> 
> if this really works, could someone point me to a working example? I 
> have copied the Documentation/sound config for OSS, changing only the 
> sound card type, and it totally doesn't work. It looks like it plays but 
> it doesn't make any sound.
> 
> I know that if I convert to ALSA I have to use their mixer to turn up 
> the sound and disable mute, if all the people telling me they do it with 
> the OSS mixer and emulation are wrong, I'll just leave the machines on 
> 2.4 until I get some time to waste.
> 
> I have read the docs I can find, this is a yes/no question, will OSS 
> work or not. I am not asking how to convert to ALSA, did that once, took 
> more time than the benefit justifies.

OSS works just fine here in 2.6, on all the machines I have. I don't use 
ALSA's OSS emulation layer, just the "native" OSS thats in the kernel. 
It's used just like in 2.4, same module names and all. No black magic 
involved.

-- 
Cheers,
André Tomt
