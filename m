Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRBIAp2>; Thu, 8 Feb 2001 19:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129672AbRBIApS>; Thu, 8 Feb 2001 19:45:18 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:16109 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129401AbRBIApJ>;
	Thu, 8 Feb 2001 19:45:09 -0500
Message-ID: <3A833D84.7060302@lycosmail.com>
Date: Thu, 08 Feb 2001 19:44:52 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac6 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mem detection problem
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE021@orsmsx31.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunlap, Randy wrote:

>> From: Adam Schrotenboer [mailto:ajschrotenboer@lycosmail.com]
>> 
>> This is actually a repost of a problem that received few 
>> serious replies (IMNSHO).
> 
> 
> Well, I claim not to have ignored it.
> I have gone thru the entire patch-2.4.1 file and can't see
> anything there that would cause what you are seeing.
> 
> You aren't using ACPI, right?  (not in your log files)
> [That just makes the patch file of interest smaller.]

Nope, result of grep ACPI .config
# CONFIG_ACPI is not set

> 
> 
>> Basically 2.4.0 detects 192 MB(maybe 191, but big whoop) of 
>> memory. This 
>> is correct. However, 2.4.1-ac6 (as did Linus-blessed 2.4.1) 
>> detects 64. 
>> The problem is simple. 2.4.1 and later for some reason uses bios-88, 
>> instead of e820.
>> 
>> Attached are the dmesgs from 2.4.0 and 2.4.1-ac6.
> 
> 
> Have you booted 2.4.0 again (lately)?  You log file is from
> Jan-08-2001.  It may also report only 64 MB now, based on
> some kind of BIOS change (or ESCD ...) since Jan-08.

Yes I have booted 2.4.0 much more recently than Jan 8.
Just checked, Jan 8 is the build date, not the boot date.

> 
> 
> Someone else with a similar "problem" actually had a fruit fly
> in one of their slots that caused a problem, so I would ask that
> you (a) boot 2.4.0 again to see if it works now and (b) remove
> adapters, clean slots, reseat adapters, boot 2.4.1 again.
> 
> ~Randy
> 
Weird, but might be worth the try, about as soon as I grab my 
screwdriver from my car (in parking lot ~1/5 mile away)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
