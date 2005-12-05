Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVLEIyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVLEIyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVLEIyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:54:22 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:60251 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750836AbVLEIyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:54:21 -0500
Message-ID: <43940039.7070502@tls.msk.ru>
Date: Mon, 05 Dec 2005 11:54:17 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
References: <43923479.3020305@tls.msk.ru> <20051204003130.GB1879@kroah.com> <386F0C1C.1040509@tls.msk.ru> <20051204230509.GC8914@kroah.com>
In-Reply-To: <20051204230509.GC8914@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Jan 02, 2000 at 11:28:12AM +0300, Michael Tokarev wrote:
[]
>>With the only problem which was here all the time - it comes "back
>>to C" after less a secound all the disks/monitor/etc are placed
>>into sleep mode..  Ie,
>>
>> ..preparing for standby...
>> ..hdd stops spinning..
>> ..monitor is turned off..
>> ..less-than-a-secound-pause..
>> Back to C!
>> ..the system goes back, restoring interrupts etc...
>>
>>I tried various 'wakeup' settings in bios, incl. turning everything
>>off in that menu - no difference.
>>
>>The same behaviour is shown by all 2.6 kernels I tried so far
>>(since 2.6.6 or so).
> 
> Does normal "suspend" work for you on this machine (echoing "disk" to
> that sysfs file?)

No, it never worked (disk or even mem) because - as i've read - linux
needs some CPU instruction (I don't remember which) which isn't implemented
on this CPU (neverless, win is pretty happy -- doing suspend/hibernate.. ;)

> I'd suggest creating a bugzilla.kernel.org entry for this new problem.

Oh well.  Ok, I'll do.  Thank you.

/mjt
