Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTF2UdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbTF2UdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:33:22 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:174 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264976AbTF2Ucx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:32:53 -0400
Date: Sun, 29 Jun 2003 16:45:26 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <200306291645260040.024A1C0C@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
 <20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:25 PM viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Jun 29, 2003 at 01:19:24PM -0700, Davide Libenzi wrote:
>
>> > AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
>> > If you can get it done - well, that might do a lot for having the
>> > idea considered seriously.  "Might" since you need to do it in a way
>> > that would survive transplantation into the kernel _and_ would scale
>> > better that O((number of filesystem types)^2).
>>
>> Maybe defining a "neutral" metadata export/import might help in limiting
>> such NFS^2 ...
>
>Go for it - do it in userland, define the mapping between various sorts
>of metadata and let's see how well you can make it work.  Have fun.

You sound like virt
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



