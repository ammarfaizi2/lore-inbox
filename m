Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTLZX4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTLZX4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:56:31 -0500
Received: from adsl-b3-72-7.telepac.pt ([213.13.72.7]:8837 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S265279AbTLZX41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:56:27 -0500
Message-ID: <3FECCAC2.2030101@vgertech.com>
Date: Fri, 26 Dec 2003 23:56:50 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org> <3FEC91FA.1050705@rackable.com> <20031226202700.GD12871@triplehelix.org> <3FECC3C1.5000108@wmich.edu>
In-Reply-To: <3FECC3C1.5000108@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ed Sweetman wrote:
> 
> I've had 2.6.0-mm1 not able to allow the button on the cdrom eject the 
> cd. the command  eject   however, does work.  No errors are reported 
> relating to why the eject button on the cdrom doesn't eject the cd.


This happens to me too, running 2.6.0-mm1. Even a music CD gets stuck 
and can only be ejected with the "eject" command. eject, after ejecting 
sucessfully the CD outputs this:

# eject
eject: unable to eject, last error: Invalid argument
#

Regards,
Nuno Silva

> 
> 
> Joshua Kwan wrote:
> 
>> On Fri, Dec 26, 2003 at 11:54:34AM -0800, Samuel Flory wrote:
>>
>>>  What does fuser -kv /mnt/cdrom claim?
>>
>>
>>
>> It's /cdrom here. I tried it on both /cdrom and /dev/cdrom after
>> unmounting it, and the output was blank.
>>
>> While mounted, here was the output:
>>
>>                      USER        PID ACCESS COMMAND
>> /cdrom               root     kernel mount  /cdrom
>> No automatic removal. Please use  umount /cdrom
>>
>> I guess that doesn't say much though...
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

