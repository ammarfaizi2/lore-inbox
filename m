Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUAOCzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266455AbUAOCzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:55:15 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:57059 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S266454AbUAOCzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:55:12 -0500
Message-ID: <4006010B.7000002@wmich.edu>
Date: Wed, 14 Jan 2004 21:55:07 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm3 lm_sensors outdated?
References: <4005CB88.5000409@wmich.edu> <20040114232052.GA9914@kroah.com>
In-Reply-To: <20040114232052.GA9914@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jan 14, 2004 at 06:06:48PM -0500, Ed Sweetman wrote:
> 
>>sensors: numerical sysctl 7 2 1 is obsolete.
>>sensors: numerical sysctl 7 2 1 is obsolete.
>>
>>I now get these warnings when loading the i2c via686a and viapro modules 
>> in my dmesg output.
> 
> 
> These warnings are coming from userspace, not the modules.
> 
> I recommend upgrading to the latest release of lmsensors (they should be
> making a new release any day now to handle 2.6.1 properly.)
> 

the modules themselves aren't making sysfs entries and lm_sensors is 
integrated with the kernel. so i tried sensors just in case and didn't 
realize it would output messages into the message log and not terminal. 
   In any case, i was simply wondering if the kernel's lm_sensors was 
outdated or if i was running into a compilation or configuration problem 
brought on by any recent changes.   It would appear though that the 
sensors in the kernel are incompatible with the kernel, at least some of 
them.

