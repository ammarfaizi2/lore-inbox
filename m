Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTEIOSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTEIOSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:18:15 -0400
Received: from windsormachine.com ([206.48.122.28]:21264 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262278AbTEIOSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:18:14 -0400
Date: Fri, 9 May 2003 10:30:47 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 3ware Raid
In-Reply-To: <20030509.13424122@knigge.local.net>
Message-ID: <Pine.LNX.4.33.0305091029510.15536-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Michael Knigge wrote:

> Hi all,
>
> this is not a "kernel-only" question but maybe someone who knows 3ware
> raid controllers (and the driver) could help me.
>
> Currently my 3ware 6xxx RAID controller tells me that my RAID-Array
> (stripe-set with two maxtor 120 GB disks) is incomplete (even if I
> delete the array and create a new one - after a reboot the array is
> marked "incomplete").
>
> The BIOS of the 3ware controller shows me both disks, but one is
> always makred as "available" and the raid-array is missing one drive.
>
> The strange part: the Linux kernel doesn't care about this and mounts
> my array correctly! And the array works so far - it seems to me, don't
> know if there will be any surprises the next days ;-)
>
>
> Now... should I care about this? Is my array broken or not? And why
> does the Linux driver think my array is ok and the 3ware BIOS not?
>
> Thanks for any help,
>   Michael

what does tw_cli say about your drive?

Can you post the output of ./tw_cli info cx where x is whatever number it
decided was your controller(which seems to be random :D)

Mike

