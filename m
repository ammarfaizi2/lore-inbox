Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTDPDHp (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 23:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbTDPDHp 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 23:07:45 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:580 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264212AbTDPDHo (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 23:07:44 -0400
Message-ID: <3E9CCBA4.3060808@myrealbox.com>
Date: Tue, 15 Apr 2003 20:19:00 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4a) Gecko/20030415
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <fa.fo1ils5.o4kt21@ifi.uio.no> <fa.jt2b7k8.20qj0c@ifi.uio.no>
In-Reply-To: <fa.jt2b7k8.20qj0c@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 15 Apr 2003 16:51:53 -0700 walt <wa1ter@myrealbox.com> wrote:
> 
> | walt wrote:

> | I can mount and unmount the Zip disk as many times as I want, as long as
> | I don't eject the disk from the drive.
> | 
> | Once I eject the disk and insert it again, the mount commant just hangs
> | forever.  No error messages anywhere -- it just hangs.  I can't even
> | kill the mount command.  The only way out is to reboot and then all is
> | well again until the next time I eject the disk from the drive.
> 
> 
> I don't know that it's _required_, but you can try doing
>   umount /mnt/zip              (or /dev/sdx)
>   eject /mnt/zip               (or dev/sdx)
> 
> and then eject it, reinsert it, try to mount, etc.?

The eject command works perfectly, just like pushing the eject button.

When I reinsert the disk in the drive I still get a permanent hang when
trying to remount the drive.

