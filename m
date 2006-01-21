Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWAUH6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWAUH6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 02:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAUH6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 02:58:40 -0500
Received: from tornado.reub.net ([202.89.145.182]:56999 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751094AbWAUH6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 02:58:39 -0500
Message-ID: <43D1E9A4.8090504@reub.net>
Date: Sat, 21 Jan 2006 20:58:28 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       neilb@cse.unsw.edu.au, linux-acpi@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
References: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>	<43D1C4E9.7030901@reub.net> <20060120214723.79111715.akpm@osdl.org>
In-Reply-To: <20060120214723.79111715.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2006 6:47 p.m., Andrew Morton wrote:

>> I've now done in excess of 20 reboots with this code and haven't had either 
>> problem show up at all.
>>
>> So for now I'll keep a record of things for a bit longer, but I guess I've 
>> reason to be fairly confident that both this USB/IRQ problem and my ATA/IRQ 
>> problem are now fixed.
>>
>> It does make me wonder if the ACPI update in rc1-mm2 fixed it, and was actually 
>> the cause of most of my problems......it would be nice to know for sure.
> 
> We probably won't know.  Did you ever test 2.6.16-rc1 plus 2.6.16-rc1-mm1's
> acpi.patch?  If that plays up we'd have confirmation.

It has been OK over 15x reboots (just tested now).  2.6.16-rc1-mm1 wasn't the 
usual standard award winning release for me because of the reiserfs problems so 
I only booted into it once and ran it for a couple of hours before retreating to 
2.6.15-rc1.

Last *known* problematic release on that box was 2.6.15-mm4.

