Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVCVMDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVCVMDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVCVMDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:03:30 -0500
Received: from smtp1.dejazzd.com ([66.109.229.7]:32144 "EHLO smtp1.dejazzd.com")
	by vger.kernel.org with ESMTP id S262658AbVCVMDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:03:15 -0500
Message-ID: <423FC2ED.1090704@ser1.net>
Date: Tue, 22 Mar 2005 02:02:05 -0500
From: Sean Russell <ser@ser1.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050226)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[01] freeze on x86_64
References: <423F5152.2010303@ser1.net> <m13buo3vew.fsf@muc.de>
In-Reply-To: <m13buo3vew.fsf@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Sean Russell <ser@ser1.net> writes:
>  
>
>>    acpi_thermal-0400 [23] acpi_thermal_get_trip_: Invalid active
>>threshold [0]
>>    
>>
>
>You mean you got this in /var/log/messages?
>  
>
Yes, in /var/log/messages.  The lock up occurs without warning, so the 
only opportunity I have to look for error messages is in the syslogs.

>Can you connect a serial console or netconsole and see if that 
>  
>
Er... by serial console, I assume you mean via a serial cable and some 
other device.  If so, then no, I don't have that capability.  I didn't 
know about netconsole before you mentioned it; I'll do some research and 
set it up.  I do have a second computer (well, my wife's laptop is also 
running Linux) that I could use to monitor UDP traffic, if I can figure 
out what to use as a client to capture the messages.  This may take me a 
couple of days.

I didn't post to the list earlier specifically because I knew the 
debugging process would rapidly exceed my knowledge about kernel 
debugging.  I appologize for making you walk me through the process.

>catches anything?  Also boot with oops=panic
>  
>
As a boot parameter?  I'll give that a try.

--- SER
