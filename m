Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWBFTV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWBFTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWBFTV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:21:58 -0500
Received: from spirit.analogic.com ([204.178.40.4]:29709 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932290AbWBFTV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:21:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200602061002.27477.joshua.kugler@uaf.edu>
X-OriginalArrivalTime: 06 Feb 2006 19:21:56.0109 (UTC) FILETIME=[97D243D0:01C62B52]
Content-class: urn:content-classes:message
Subject: Re: Linux drivers management
Date: Mon, 6 Feb 2006 14:21:55 -0500
Message-ID: <Pine.LNX.4.61.0602061420400.17351@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux drivers management
Thread-Index: AcYrUpfeeu4bef2kRNmuecve+d4Apg==
References: <1139250712.20009.20.camel@rousalka.dyndns.org> <200602061002.27477.joshua.kugler@uaf.edu>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Joshua Kugler" <joshua.kugler@uaf.edu>
Cc: <linux-kernel@vger.kernel.org>,
       "Nicolas Mailhot" <nicolas.mailhot@laposte.net>,
       "David Chow" <davidchow@shaolinmicro.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Feb 2006, Joshua Kugler wrote:

> On Monday 06 February 2006 09:31, Nicolas Mailhot wrote:
>>> I think I am in a different position like you guys, I've been work with
>>> Linux from programmer level to Linux promotion . My goal is not just
>>> focus on Linux technical or programming, I would like to promote this
>>> operating system to not just for programmers, but also non-technical
>>> end-users .
>>
>> Since you invoke end-users I'll answer.
>
> I heartily agree with this!!
>
> I use two products that use out-of-tree drivers.  VMWare and NVidia cards.
> Fortunately, the build processes for both are rather painless, but there have
> been times when it has *not* been, and it was extremely frustrating.  I
> remember when VMWare was not doing a good job of supporting 2.6 kernels and I
> spent the better part of two days trying to track down a solution.  I finally
> did, but it was a third party, non-VMWare, patch to the VMWare code that
> fixed it so it would compile and run.  That's not what I consider convenience
> for the non-technical user.  A non-technical user would not have been able to
> do what I did, especially when they just want their software to work.
>
>> Do you really think we enjoy clicking though boatloads of HTML/js/flash
>> forms that will inform us about vastly important things like your custom
>> license, the mirror list you want us to master or your dog's birthday ?
>
> I want to install my machine and have everything work.  Don't make me chase
> all over the net trying to find a driver for my hardware.  If it's a network
> (i.e. ethernet device) the driver had *better* be in the tree.  Trying to
> download the driver to another computer, transferring, etc, is enough to make
> me find another brand of network card.
>
>> Do you really think we enjoy learning all your out-of-tree driver
>> release and build processes because you couldn't be bothered with using
>> the same one as the kernel ?
>
> Latest kernel == latest driver.  No need for me to try to keep all my drivers
> up to date.
>
>> Do you really think we enjoy locating the patch that will "fix" your
>> driver for our kernel because you do not bother testing anything else
>> than a few kernel releases, and that only for a few months after a you
>> wrote your driver ?
>
> See comment about VMWare above.
>
>> Do you really think we enjoy leaving in fear of a system update because
>> the first thing to break will be your out-of-tree drivers ?
>
> I sometimes delay kernel updates because I don't want to mess with updating my
> NVidia and VMWare drivers.  This is *not* good for security.
>
>> But do not invoke end-users. Or end users will answer you.
>
> So I did.  Please put your driver in the tree.  It will be better for all
> concerned.
>
> j----- k-----
>
> --
> Joshua Kugler                 PGP Key: http://pgp.mit.edu/
> CDE System Administrator             ID 0xDB26D7CE
> http://distance.uaf.edu/


Maybe it would be better for no drivers to be in the tree!
Something along the lines of an automatic FTP site that
interacts with a configuration program. You end up downloading
the drivers that you need. In the case where you don't have
an Internet connection, a distribution company would put the
mirror on a CD or DVD.

Right now, there are really too many drivers in the kernel.
The kernel should have a stable API for drivers and they
should be in a separate tree, either on the Web or on a
distribution disc. There are many drivers that are as old
as Linux! The 3c501.c and 3c503.c are examples. You can't
remove them from the kernel without invoking a thousand
angry responses. These boards and the ne*.c network boards
just won't go away!

This means that the amount of drivers will continue to
increase to, eventually, an unmanagable amount. This is
why they really need to be seperately managed!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
