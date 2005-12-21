Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVLUWqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVLUWqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVLUWqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:46:33 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:39851 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S964868AbVLUWqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:46:32 -0500
Date: Wed, 21 Dec 2005 17:46:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
In-reply-to: <20051221230725.4a4851fa.khali@linux-fr.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200512211746.30965.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512201505.43199.gene.heskett@verizon.net>
 <200512211551.39092.gene.heskett@verizon.net>
 <20051221230725.4a4851fa.khali@linux-fr.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 17:07, Jean Delvare wrote:
>Hi Gene,
>
>Please keep this conversation on the LKML, where it started.
>
>> > Are you getting the temperature value from ACPI, or from a hwmon
>> > driver? If the latter, which driver is this, and which hardware
>> > monitoring chip do you have?
>>
>> Its coming from whatever source gkrellm-2.1.28 uses as the default
>> src for this, selecting other src's results in -200F or more
>> readings. Rebooting back to -rc5, the readings are normal but
>> creeping up, about 152F right now.
>
>That's hardly helpful. If gkrellm doesn't tell you where the data
> comes from, we just can't use it to debug any issue. Please use
> "sensors" instead.
>
>> >From sensors-detect:
>>
>> Probing for `Winbond W83627HF'
>>   Trying address 0x0290... Success!
>>     (confidence 8, driver `w83781d')
>>
>> What else?
>
>This is only one part of sensors-detect. I guess it then suggests the
>w83627hf driver instead. Which driver are you using, w83627hf or
>w83781d?
>
>Please provide:
>
>1* The complete output of sensors-detect.
>
>2* The output of "sensors" in 2.6.15-rc5.
>
>3* The output of "sensors" in 2.6.15-rc6.
>
>4* The diff of your 2.6.15-rc5 kernel config file and 2.6.15-rc6
>kernel config file.
>
>Thanks,

I've sent the above info, but there is a nilmreg here someplace.  I'm 
currently booted to 2.6.15-rc6, and both sensors, and gkrellm are 
working fine.

And, FWIW, so apparently is ntpd......

One of those things that make you go 'Hummmm'.

Uptime now about 30 minutes, no messages in the log and the toolbar 
clock is staying about 4 seconds behind my watch.

Anybody got any nilmerg spray?  Looks like I need a gallon. :(

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
