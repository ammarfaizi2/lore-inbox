Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266012AbUFEEAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266012AbUFEEAe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 00:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUFEEAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 00:00:34 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:59806 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266012AbUFEEAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 00:00:32 -0400
Message-ID: <40C1455E.30501@blueyonder.co.uk>
Date: Sat, 05 Jun 2004 05:00:30 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com> <1086385540.2241.322.camel@dhcppc4>
In-Reply-To: <1086385540.2241.322.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2004 04:00:33.0937 (UTC) FILETIME=[A6AF0010:01C44AB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

>On Thu, 2004-06-03 at 18:04, Sid Boyce wrote:
>  
>
>>Reversing Bjorn's ACPI patch fixed it.
>>    
>>
>
>Sid,
>Does it work better if you build IOAPIC support into the kernel?
>
>Please send me the complete failing .config
>and I'll try to reproduce it on my nforce2 box.
>
>thanks,
>-Len
>
>
>
>  
>
I just built and successfully booted 2.6.7-rc2-mm2 IOAPIC enabled and 
without boot option acpi=off. I guess somewhere IOAPIC was inadvertently 
disabled in .config.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

