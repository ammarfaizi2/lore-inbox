Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVJEOxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVJEOxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbVJEOxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:53:11 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:37130 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965186AbVJEOxK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:53:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051005144441.GC8011@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
X-OriginalArrivalTime: 05 Oct 2005 14:52:59.0377 (UTC) FILETIME=[7A5B5E10:01C5C9BC]
Content-class: urn:content-classes:message
Subject: Re: what's next for the linux kernel?
Date: Wed, 5 Oct 2005 10:52:59 -0400
Message-ID: <Pine.LNX.4.61.0510051048090.5182@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what's next for the linux kernel?
Thread-Index: AcXJvHpiq5EhAsgzRyqyUSzBKJPCYg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: "Marc Perkel" <marc@perkel.com>, "Nix" <nix@esperi.org.uk>,
       <7eggert@gmx.de>, "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Lennart Sorensen wrote:

> On Wed, Oct 05, 2005 at 07:41:21AM -0700, Marc Perkel wrote:
>> If you were going to do it right here's what you would do:
>>
>> People who had files in /tmp would have no rights at all to other users
>> /tmp files.
>> Listing the dirtectory would only display the files you had some access
>> to. If you have no rights you don't even see that the file is there.
>> The effect would be like giving people their own tmp directories.
>
> Except it still wouldn't be able to go: Does file xyz exist?  If not,
> create file xyz.  If someone else had xyz that you didn't see, you would
> still not be able to create it.  So what is the point of NOT showing it
> other than to make it much harder to avoid conflicting names?
>
> if you want to not see files that you have no rights to, filter it in
> your user space application when it matters, and let user space see the
> files when they need to in order to avoid name conflicts.
>
> It would be an incredibly idiotic system that auto hides files just
> because you can't use them.  We have ways to hide files in user space
> for the convinience of users.  It would be too inconvinient for
> applications if the OS hid files on us.
>
> Len Sorensen
> -

Also it has nothing at all to do with the kernel. It's what `ls`
or some other directory-reading program provides for the user.
People often forget that PATH, `pwd`, etc., are just filter
components!

When you `cd` to somewhere, your location hasn't changed at
all!

Without involving the kernel, one can make any kind of filter
to cause any sort of display that you want.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
