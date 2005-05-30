Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVE3Krn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVE3Krn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVE3Krn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:47:43 -0400
Received: from smtp08.web.de ([217.72.192.226]:40664 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261376AbVE3Kr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:47:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <4847F-8q-23@gated-at.bofh.it>
	<E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
	<4295005F.nail2KW319F89@burner>
	<8E909B69-1F19-4520-B162-B811E288B647@mac.com>
	<4296EADA.nail3L111R0J3@burner>
	<d120d500050527072146c2e5ee@mail.gmail.com>
	<429AD7ED.nail4ZG1B42TI@burner>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Mon, 30 May 2005 12:47:25 +0200
In-Reply-To: <429AD7ED.nail4ZG1B42TI@burner> (Joerg Schilling's message of
 "Mon, 30 May 2005 11:07:57 +0200")
Message-ID: <87ekbpat36.fsf@plailis.daheim.bs>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> > Cdrecord includes the needed features to do what you like, but do
>> > not asume that you will be able to force me to make nonportable and
>> > Linux specific interfaces a gauge for the design of a portable
>> > program.  If you read the cdrecord man page, you know that you
>> > could happily call cdrecord dev=green_burner.....
>> > 
>>
>> No, that static mapping is not good. I have an external enclosure
>> that does firewire and USB. I want to be able to use "sony-dvd" to
>> access it no matter whether it is onnected to USB bus or Firewire and
>> whether there are other devices (disks) on USB or firewire. It is
>> possible to do with udev creating a link to /dev/sony-dvd.
>
> I am not sure what you like to do.....

He wants to be able to access his dvd recorder via dev=/sony-dvd. And it
should not matter how it is connected (USB/firewire).

> But what you claim is simply impossible.

No it is not.

> As you started to introduce the allegory with the colors, let me make
> an assumption based on your claim:
>
> -	Buy two identical drives and varnish one in red and the other 
> 	in green.

That is indeed impossible, but as soon as there are two different
drives, it is possible with udev and not possible with a static
assignment.

regards
Markus

