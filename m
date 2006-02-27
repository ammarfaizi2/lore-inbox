Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWB0VVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWB0VVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWB0VVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:21:49 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:50631 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S1751834AbWB0VVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:21:48 -0500
Date: Mon, 27 Feb 2006 15:21:42 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060227212141.GA1334769@hiwaay.net>
References: <fa.deNPP6WI8uOxYJJt5IRsDHJHqNc@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44035FF4.8070600@tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Bill Davidsen  <davidsen@tmr.com> said:
>> Which is bad, as it is incomplete and requires the kernel be updated to
>> know about every format just to document them.
>
>Document them where? In the kernel Documentation directory? I believe
>those strings come back from the drive, as long as the human or
>application can parse them the kernel operationally needs only what you
>mentioned below.

I wasn't aware those strings actually came from the devices.  What I
meant was if that file is to be the documentation of the drive
capabilities, it needs to be updated to list all known capabilities (and
be updated promptly when new capabilities are created).  It currently
has many missing formats.

>> - What is "drive speed" (no units); also most drives do different speeds
>>   for different modes/media.
>
>Presumably the max speed mechanically possible, in the units of "x"
>which are used to identify both media and burners and have been since
>"2x" was the fast burner.

I've got a burner that has the following burn speeds (from memory): 16x
DVD+/-R, 8x DVD+RW, 6x DVD-RW, 4x DVD+/-R DL, 48x CD-R, and 24x CD-RW.
I don't even remember what the max read speeds are.  Which is the "max"?
The 16x DVD speed or the 48x CD speed?  Why?

The "x" unit is only meaningful with an associated format (since "1x" is
different for different formats) and with "read" or "write" specified.

Without units, the number is meaningless.

>> - if the drive can handle rewritable formats (for UDF support)
>
>CD-RW seems to cover that.

Not for DVD+RW, DVD-RW, and DVD-RAM (which is the only one there).
Sometime down the road, HD-DVD and Blu-Ray versions of rewritable will
also exist.
