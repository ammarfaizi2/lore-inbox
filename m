Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRKVRy7>; Thu, 22 Nov 2001 12:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280948AbRKVRyu>; Thu, 22 Nov 2001 12:54:50 -0500
Received: from mail.gmd.de ([129.26.8.90]:50955 "EHLO mail.gmd.de")
	by vger.kernel.org with ESMTP id <S280814AbRKVRyi>;
	Thu, 22 Nov 2001 12:54:38 -0500
Message-ID: <3BFD3B5A.3010701@gmd.de>
Date: Thu, 22 Nov 2001 18:52:26 +0100
From: Pavel Frolov <pavel.frolov@gmd.de>
Organization: GMD
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 freeze
In-Reply-To: <Pine.LNX.4.10.10111221122210.31054-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is dealed with HIGHMEM.
When i disable it all is working good.

I will decode oops later.

Mark Hahn wrote:

> please decode the oopses as described in the faq.
> without you decoding them, they're not meaningful,
> since the addresses are for your kernel only.
> 
> but let me also ask: is the freeze consistently 2 minutes
> after boot?  if so, I'd guess the problem is power-management,
> which you should probably try switching off in BIOS.
> 
> 
> 
>>Hi, all!
>>     I have HP X4000 workstation (2CPU P4 Xeon 1.7GHz: 1G RAM) and i am 
>>trying to use it in cluster as client PC with booting
>>over network.
>>     But after about 2min computer freeze when i dont use syslog and klog.
>>     When i am using syslog and klog i get  oops message directly after 
>>syslog start and before kernel freeze.
>>      If i am trying use it UP configuration with APIC then APIC reports 
>>it gets unknown configuration.
>>     In attachment dmesg output befor freeze and kernel .config file.
>>																		pasha.
>>
>>
>>
> 



