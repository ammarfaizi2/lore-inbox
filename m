Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbUJ2FAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbUJ2FAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbUJ2FAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 01:00:36 -0400
Received: from mx15.sac.fedex.com ([199.81.195.17]:9486 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S263094AbUJ2FAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 01:00:32 -0400
Date: Fri, 29 Oct 2004 12:58:34 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Alasdair G Kergon <agk@redhat.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Andrew Morton <akpm@osdl.org>,
       Mathieu Segaud <matt@minas-morgul.org>, axboe@suse.de,
       jfannin1@columbus.rr.com, christophe@saout.de,
       Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
In-Reply-To: <20041028145604.GA20448@agk.surrey.redhat.com>
Message-ID: <Pine.LNX.4.61.0410291256200.17690@silk.corp.fedex.com>
References: <20041026135955.GA9937@agk.surrey.redhat.com>
 <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org>
 <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org>
 <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
 <877jpcgolt.fsf@barad-dur.crans.org> <20041027132422.760d5f5e.akpm@osdl.org>
 <Pine.LNX.4.61.0410281245240.31882@silk.corp.fedex.com>
 <20041028145604.GA20448@agk.surrey.redhat.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/29/2004
 01:00:23 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/29/2004
 01:00:26 PM,
	Serialize complete at 10/29/2004 01:00:26 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Alasdair G Kergon wrote:

> On Thu, Oct 28, 2004 at 12:52:20PM +0800, Jeff Chua wrote:
>> I'm using 2.6.10-rc1 and got the following error ...
>> # lvcreate -L 100M -n lv01 vg01
>>   device-mapper ioctl cmd 0 failed: Inappropriate ioctl for device
>>   striped: Required device-mapper target(s) not detected in your kernel
>>   lvcreate: Create a logical volume
>
> But that's *not* the dio problem we're discussing in this thread.
> It's saying userspace communication with device-mapper isn't working,
> most likely because there's something wrong with the way your
> system creates /dev/mapper/control when booting or the ioctl
> compatibility code (what architecture?).

doesn't make any sense to me. Why would 2.6.9 works then?
Architecture is Intel running on IBM X31 notebook.

Never had LVM problem until 2.6.10-rc1. It just went dead.

Jeff.
