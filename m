Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLLVYS>; Tue, 12 Dec 2000 16:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLLVYJ>; Tue, 12 Dec 2000 16:24:09 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:21253 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129602AbQLLVXv>; Tue, 12 Dec 2000 16:23:51 -0500
Message-ID: <3A368FE2.1050205@megapathdsl.net>
Date: Tue, 12 Dec 2000 12:51:46 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001208
X-Accept-Language: en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: Greg KH <greg@wirex.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <Pine.LNX.4.30.0012121536510.1461-100000@viper.haque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try reading:

	http://www.linuxhq.com/kernel/v2.3/doc/oops-tracing.txt.html

It mentions:

     Patch the kernel with one of the crash dump patches.  These save
     data to a floppy disk or video rom or a swap partition.  None of
     these are standard kernel patches so you have to find and apply
     them yourself.  Search kernel archives for kmsgdump, lkcd and
     oops+smram.

I don't know if the "dump to floppy" patch is maintained for the
2.4.0 series.

	Miles

Mohammad A. Haque wrote:

> Nope, this didn't fly. Would have been neat if it did work. Maybe it can
> be made to work for future use?
> 
> On Tue, 12 Dec 2000, Greg KH wrote:
> 
> 
>> I don't know if /dev/ttyUSBX would work, but I think it would.  People
>> have successfully run consoles through the usb-serial drivers, but I'm
>> not sure if the oops main console requires something different (like
>> registering itself actually as a console?)
>> 
>> And then there's the nice problem of the fact that if the oops comes
>> from the USB code, you will not see it come out the usb-serial driver :)
>> 
>> Let me know if you try this, and have any success (or find that it
>> doesn't work.)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
