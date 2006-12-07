Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937905AbWLGBN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937905AbWLGBN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937901AbWLGBN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:13:59 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45619 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937905AbWLGBN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:13:58 -0500
Date: Wed, 06 Dec 2006 18:02:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
In-reply-to: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Message-id: <45775A32.2050506@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Hi
> 
> 
> I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
> (currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)

All the same enclosure type?

> This time i kept the defective files and used "vbindiff" to show me the
> difference. Strangly in EVERY case the difference is a single bit in a
> sequence of "0xff"-Bytes inside a block of varing bit-values that
> changed a "0xff" into a "0xf7".
> Also interesting is that each error is at a 0xXXXXXXX5-Position
> 
> Attached is a file with 5 of the 6 differences named 1-5. Of each of the
> 5 2x3 lines-blocks the first 3 lines are the original the following 3
> lines contain the error in the middle row 6th value.
> 
> NEVER did i see any messages in syslog regarding erros or an aborting
> program due to errors passed down from the kernel or something like that.

The fact that the corruption seems data dependent would seem to me to 
point to some kind of hardware problem. I would tend to suspect the 
USB-to-IDE converters in the enclosures as being faulty or something 
like that..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

