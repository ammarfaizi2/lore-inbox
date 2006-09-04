Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWIDRcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWIDRcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWIDRcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:32:14 -0400
Received: from mserv2.uoregon.edu ([128.223.142.41]:13742 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S964963AbWIDRcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:32:13 -0400
Message-ID: <44FC62E0.6030202@uoregon.edu>
Date: Mon, 04 Sep 2006 10:31:12 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marc Perkel <marc@perkel.com>,
       Adam Kropelin <akropel1@rochester.rr.com>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Linux: Why software RAID?
References: <20060824090741.J30362@mail.kroptech.com>	 <1156425650.3007.140.camel@localhost.localdomain>	 <44EDB843.2020608@perkel.com> <1156432892.3007.155.camel@localhost.localdomain> <44FC62EF.7040100@tmr.com>
In-Reply-To: <44FC62EF.7040100@tmr.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:
> Alan Cox wrote:
> 
>> Ar Iau, 2006-08-24 am 07:31 -0700, ysgrifennodd Marc Perkel:
>>  
>>
>>> So - the bottom line answer to my question is that unless you are
>>> running raid 5 and you have a high powered raid card with cache and
>>> battery backup that there is no significant speed increase to use
>>> hardware raid. For raid 0 there is no advantage.
>>>
>>>   
>> If your raid is entirely on PCI plug in cards and you are doing RAID1
>> there is a speed up using hardware assisted raid because of the PCI bus
>> contention.
>>
> 
> I would expect to see this with RAID5 as well, for the same reason...

assuming you actually have lots of pci contention that might be a
consideration... if you're sitting on server class hardware with
multiple pci buses or using pci-express cards that won't be a
significant issue.

-- 
------------------------------------------------------------------------
Joel Jaeggli             Unix Consulting              joelja@uoregon.edu
GPG Key Fingerprint:   5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
