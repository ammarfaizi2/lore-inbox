Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUFEWIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUFEWIS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUFEWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:08:18 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:21750 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262101AbUFEWIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:08:13 -0400
Message-ID: <40C2444B.4080403@blueyonder.co.uk>
Date: Sat, 05 Jun 2004 23:08:11 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com> <1086385540.2241.322.camel@dhcppc4> <40C1455E.30501@blueyonder.co.uk> <200406050937.29163.bjorn.helgaas@hp.com>
In-Reply-To: <200406050937.29163.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2004 22:08:15.0222 (UTC) FILETIME=[9970D160:01C44B49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:

>On Friday 04 June 2004 10:00 pm, Sid Boyce wrote:
>  
>
>>I just built and successfully booted 2.6.7-rc2-mm2 IOAPIC enabled and 
>>without boot option acpi=off. I guess somewhere IOAPIC was inadvertently 
>>disabled in .config.
>>    
>>
>
>So I guess IOAPIC was enabled in your pre-mm1 builds that worked?
>
>I just want to make sure my patch doesn't add a requirement for
>IOAPIC where it wasn't required before.
>
>My assumption is that
>	- 2.6.7-rc2 without IOAPIC fails (I'm not sure you've tried
>		this; I don't think I've seen a report either way)
>  
>
That works. Somewhere along the way, IOAPIC got removed from my .config.

>	- 2.6.7-rc2 with IOAPIC works
>  
>
I haven't tried.
 

>	- 2.6.7-rc2-mm2 without IOAPIC fails
>  
>
Correct.

>	- 2.6.7-rc2-mm2 with IOAPIC works
>  
>
Correct.
Regards
Sid.


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

