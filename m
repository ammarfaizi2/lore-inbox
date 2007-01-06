Return-Path: <linux-kernel-owner+w=401wt.eu-S1751074AbXAFBqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbXAFBqi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbXAFBqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:46:38 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:65422 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbXAFBqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:46:37 -0500
Date: Fri, 05 Jan 2007 20:46:33 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: PL2303 module
In-reply-to: <20070106013253.GA7777@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Message-id: <200701052046.34066.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200612272248.06893.gene.heskett@verizon.net>
 <200701052025.59620.gene.heskett@verizon.net> <20070106013253.GA7777@kroah.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 20:32, Greg KH wrote:
[...]
>> >
>> >It should work like any other serial port on Linux, so try the serial
>> >port programming HOWTO.
>>
>> Maybe so Greg, but I spent quite some time on it a few months back,
>> trying to make '7 wire' protocol work, could not.  I could type back
>> and forth between terminal proggies, but an rzsz file transfer never
>> got past the first packet.
>
>Hm, a number of the "odd" settings might not work on the usb-serial
>converters, as they can't do them (or the driver doesn't know how to
>configure the chip to do that.)

There is absolutely nothing 'odd' about the '7 wire', it is _the_ standard 
for bi-directional hardware flow control, in common usage for at least 25 
years that I'm aware of.

>The pl2303 driver was reverse engineered by looking at data from other
>operating systems, so perhaps no one has added that mode to it.

Humm, src code snooping time I guess, when I get a chance.  Right now its 
a race against time to get us on the air with a fresher transmitter since 
I can no longer get 4-1000 tubes to service our old GE, and the ones in 
it are on their last month.  So I'm outta here in a few minutes to go see 
if I can do a decent job of cutting 3.125" transmission lines on a 12" 
chop saw with a carbide blade.

>good luck,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.
