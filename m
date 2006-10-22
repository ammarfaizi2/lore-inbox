Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWJVLVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWJVLVb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 07:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWJVLVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 07:21:31 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:108 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932386AbWJVLVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 07:21:30 -0400
Date: Sun, 22 Oct 2006 07:20:59 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: WAS Re: 2.6.19-rc1, timebomb?, now -rc2 progress
In-reply-to: <200610212011.37914.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, Chris Largret <largret@gmail.com>
Message-id: <200610220720.59531.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200610200130.44820.gene.heskett@verizon.net>
 <p731wp1mvhs.fsf@verdi.suse.de> <200610212011.37914.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 20:11, Gene Heskett wrote:
>On Saturday 21 October 2006 13:25, Andi Kleen wrote:
>>Gene Heskett <gene.heskett@verizon.net> writes:
>>> ISTR that was the second time an un-logged powerdown has been done
>>> since that kernel became the default.
>>
>>It might be overheating. During a critical overheat condition the
>>ACPI code will just power off. It should still get console messages
>>out (but nothing on disk), so if you configure serial or net console
>>you would see a message.
>>
>>And check your fans are ok.
>>
>>-Andi
>>-
>
>Thanks Andi, but heating isn't a problem that I'm aware of, I'm no longer
>running a seti client since they moved it all to BOINC & refused to set
>priorities to reasonable values.  Cpu temps are pretty steady at 120F.
>
>I tried to build and boot to 2.6.19-rc2 twice today, but each time it
> fails at the initrd read phase, saying no (mutter) or cpio magic.  And
> this is with exactly the same command line as always generating the
> initrd and then copying it to the /boot partition.  This works well for
> 2.6.18, which I just rebuilt after having discovered I'd lost the himem
> magic somehow.

Someplace along the line, either a make oldconfig screwed up, or my .config 
chain of succession my scripts use got totally fubared when I was trying 
to build 19-rc2.

After 3 more rebuilds to add stuff like emu10k1 & the RAMFS bits, -rc2 has 
now booted.  So now we wait for the other shoe to drop & see if the auto 
powerdowns persist.
[...]
>I haven't tried to setup a seriel console because both serial ports on
> this box are already busy with other things.  I could free a serial port
> if someone could tell me howto make the bulldog ups monitoring software
> from belkin use a usb port instead.  Anyone have a clue to share on that
> subject?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
