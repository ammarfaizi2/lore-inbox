Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbTCONhS>; Sat, 15 Mar 2003 08:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTCONhS>; Sat, 15 Mar 2003 08:37:18 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:60135 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261449AbTCONhR>;
	Sat, 15 Mar 2003 08:37:17 -0500
Message-ID: <3E732F0F.6000806@colorfullife.com>
Date: Sat, 15 Mar 2003 14:47:59 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: war@lucidpixels.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5702 Major Problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:

>[*] IO-APIC support on uniprocessors
>
I think the subject is a bit misleading:
There seems to be a problem with interrupt routing if he enables IO-APIC 
support, both with a Broadcom nic and a 3com nic.
Either the MP table that is supplied by the bios is incorrect [wouldn't 
be a big surprise - I think Linux is the only OS that looks at MP tables 
of uniprocessor machines], or the ACPI interpreter did something wrong.

Do you use the latest bios for your motherboard? Which chipset?

--
    Manfred




