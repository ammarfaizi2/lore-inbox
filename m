Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTJCJI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 05:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTJCJI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 05:08:28 -0400
Received: from main.gmane.org ([80.91.224.249]:32442 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263654AbTJCJIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 05:08:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [BUG?] lost interrupt
Date: Fri, 03 Oct 2003 11:08:22 +0200
Message-ID: <yw1xpthen0xl.fsf@users.sourceforge.net>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <20031003083837.GA5036@indigita.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:r1tWNxOsise43o7pAYqDboHemR4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Caldwell <david+kernel@porkrind.org> writes:

>> With all 2.6.0 versions so far, I get these errors when writing lots
>> of data to the disk:
>
> I am getting these same errors with 2.6.0-test6. The difference is,
> I'm not using a SiS IDE controller. I have a Promise 20276 on my
> motherboard which was the controller getting the lost interrupt
> error. I am running RAID5 using disks on this controller and on a
> Promise 20267 PCI card (note: 67 not 76!). I seemed to start getting
> the error when my disks started going with lots of activity.
>
> I had booted with "noapic" at the time. Without "noapic" my
> motherboard wouldn't boot at all (it seemed to hang right after
> detecting the IDE devices, but I don't know if that is relevant).

That doesn't make any difference for me.

>> Losing too many ticks!
>> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
>> Falling back to a sane timesource.
>
> I was definitely getting this same error.
>
>> hda: lost interrupt
>> hda: lost interrupt
>> hda: lost interrupt
>> hda: lost interrupt
>
> I was definitely getting this error, except it was on hdg (my promise
> 20276).
>
>> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> 
>> hda: drive not ready for command
>
> I don't remember if I was getting this error or not.
>
>
> I didn't have the forethought to save my dmesg output. This screwed up
> my RAID pretty bad, so I'm a little reticent about making it happen
> again...

In my case, no data is lost.  It just takes an awfully long time to
write it.

> I just wanted to let it known that it wasn't just happening to SiS IDE
> controllers.

Could you post your dmesg output for that machine?  It might reveal
something, even the error doesn't occur.

-- 
Måns Rullgård
mru@users.sf.net

