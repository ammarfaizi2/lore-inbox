Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTF2TyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTF2Twl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:52:41 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:1935 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264190AbTF2TwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:52:24 -0400
Date: Sun, 29 Jun 2003 16:05:40 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFF4443.8080507@sktc.net>
To: "David D. Hagood" <wowbagger@sktc.net>, linux-kernel@vger.kernel.org
Message-id: <200306291605400290.0225B33F@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net>
 <200306291431080580.01CF24BF@smtp.comcast.net> <3EFF4443.8080507@sktc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 2:55 PM David D. Hagood wrote:

>rmoser wrote:
>
>> Ass yourself for hours, each time risking making a typo and killing both
>> filesystems, or risking having the LVM resize die from a powerdrop or a
>kick
>> to the power button (sorry we don't all have immortal fault tolerance).
>I actually
>> though about this one and figured it was too rediculously annoying to
>actually
>> bring up :-p
>>
>
>> I've never used LVM, but I'll look at it one day.  If it's stable,
>that's good; I
>> don't use Windows.  I don't know exactly what LVM is but I have a pretty
>> good idea; it's been forever since I read the doc on it, I forgot what
>it said!
>>
>
>
>Funny how, having never used LVM you have an opinion about it.
>
>I have. I have done EXACTLY what I described.
>
>First of all, do you REALLY think my way is any less failure prone,
>especially in the presence of the possiblilty of power failure than any
>other method? My method preserves a mountable, valid file system at each
>step of the way - the resized downward of the old file system, the
>resize upward of the new, the file copy.
>

Except for a crash at the precise moment that data is being written during
a resize of a partition in LVM or the filesystem iteself.  To my knowledge,
said operation is not journaled.

WTF is the doc for this?  wth do I have an incomplete Documentation/ tree
or something?  I dunno, maybe I read about LVM on some site or something.
It doesn't matter; it's been too many years since I've though about it or read
about it or even seen it.

>Secondly, if you are REALLY concerned about the manual aspect of what I
>suggested, you can write a simple shell script to do the work.
>
>Third of all, the longest parts of the process I describe will be the
>resize downward of the old file system and the copy of the data - the
>LVM parts of this operation are pretty damn quick.



