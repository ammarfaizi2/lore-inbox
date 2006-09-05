Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWIEUGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWIEUGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWIEUGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:06:34 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:15762 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030236AbWIEUGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:06:33 -0400
Date: Tue, 05 Sep 2006 16:02:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.18-rc6
In-reply-to: <200609051704.41576.s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Message-id: <200609051602.26861.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
 <200609042017.03515.gene.heskett@verizon.net>
 <200609051704.41576.s0348365@sms.ed.ac.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 September 2006 12:04, Alistair John Strachan wrote:
>On Tuesday 05 September 2006 01:17, Gene Heskett wrote:
>> On Monday 04 September 2006 18:31, Steffen Klassert wrote:
>> >On Mon, Sep 04, 2006 at 07:05:53AM -0400, Gene Heskett wrote:
>> >> On Sunday 03 September 2006 22:42, Linus Torvalds wrote:
>> >> >Things are definitely calming down, and while I'm not ready to call
>> >> > it a final 2.6.18 yet, this migt be the last -rc.
>> >>
>> >> It has one new build warning, no idea if show stopper or not:
>> >> ----------
>> >> drivers/usb/input/hid-core.c:1447:1: warning:
>> >> "USB_DEVICE_ID_GTCO_404" redefined
>> >> drivers/usb/input/hid-core.c:1446:1: warning: this is the location
>> >> of the previous definition
>> >> ----------
>> >> until after I boot to it...
>> >>
>> >> And that didn't seem to effect the mouse.  Other usb stuff has not
>> >> been exersized yet.
>> >
>> >The offending patch is
>> >hid-core.c: Adds all GTCO CalComp Digitizers and InterWrite School
>> > Products to blacklist
>
>[snip]
>
>> Sep  3 19:27:17 coyote kernel: usb 3-2.1: reset low speed USB device
>> using ohci_hcd and address 3
>> Sep  3 19:35:45 coyote kernel: usb 3-2.1: reset low speed USB device
>> using ohci_hcd and address 3
>
>Might not be a kernel problem, userspace might be using libusb and
> calling usb_reset() on the device. Try dropping out of X11 and see if it
> still happens.

Unforch, its intermittent, and hasn't done it since the early evening hours 
yesterday.  As an experiment, I just moved another wireless M$ mouse that 
normally sits on a corner of the same mousepad, one thats normally used 
with my lappy, to a point a couple of feet away.  Which if its crosstalk 
in the base station, won't help as the base station is still about 4 feet 
from both mice.  I probably should take the battery out of it when the 
lappy isn't running.  M$ really should have put a power switch on a mouse 
they know very well is going to be used on a lappy cause when you toss it 
in the bag with the rest of the detrius of a laptop, it can't find a pad 
surface and goes blinking crazy till you take the *&^$ battery out.

So I suspect I'm barking up the wrong tree after all...  Sorry.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
