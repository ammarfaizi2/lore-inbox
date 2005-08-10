Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVHJWNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVHJWNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVHJWNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:13:21 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:33343 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932430AbVHJWNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:13:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ZHD9870VyPaP6l2qejVGd6mUiMsX5W+08IkOeCktt9XX/2iV8GOtj5xv5CGlL5EZC2JULySCG7oP/RGsfNWgWbTpSJNn0kZeubwoshwhmuYuTc5PtIfljir5WPEyX0R5jidIIcy4xM8xhKT1zbNYe6JuHDrA41PDDEyTTAtA4Z4=
Message-ID: <42FA7BE8.3070000@gmail.com>
Date: Thu, 11 Aug 2005 00:12:56 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: David Madore <david.madore@ens.fr>
CC: Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: Re: how do I read CPU temperature in ACPI? (w/ P5WD2 motherboard)
References: <20050810213802.GA8105@clipper.ens.fr>
In-Reply-To: <20050810213802.GA8105@clipper.ens.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore schrieb:

>Hi.  I apologize for what is surely a stupid question: I understand
>that ACPI should be able to tell me what my CPU's temperature is (I
>have a sever overheating problem and I am trying to solve it by
>underclocking somewhat, but I need to be able to read the temperature
>to do anything worth while), but no matter what ACPI modules I load, I
>can't find any hint of a CPU temperature reading anywhere below
>/proc/acpi (the /proc/acpi/thermal_zone/ directory, for example,
>remains empty).
>
>That's with the "thermal", "processor" and "fan" modules loaded (and a
>few others; full listing follows signature).  I tried to load the
>asus_acpi module also, since I have an ASUS motherboard (a P5WD2
>Premium - precise details are given below signature), but I got a "No
>such device" error.  Does that mean my motherboard is unsupported and
>I cannot read my CPU temperature at all?  (But I thought the whole
>_point_ of ACPI was that it was an abstraction away from the hardware:
>so why is there such a thing as "Asus" ACPI?)  Or else, what am I
>doing wrong?
>
>  
>
Hello David,

you will have no luck. I also have this Mainboard in my test rig.
1.) The Super/IO Winbond W83627EHG-A is not supported yet by lm_sensors2 
or any driver I know of.
2.) I also can't get acpi temperature on Gigabyte 955X Royal and 925Xe 
Mobo, Abit 925XE, ASUS P5AD2-E 925XE, P5WD2 955X too.

The ASUS P5WD2 also has some **EXECUTABLE CODE*** in ACPI Table that 
cause some errors here..regarding ACPI stuff *sigh*

But on the Gigabyte they use a IT8212F Super IO so you can use lm_sensors2.

I hope I could help a bit.

Greets

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



