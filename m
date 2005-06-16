Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFPJZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFPJZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 05:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFPJZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 05:25:10 -0400
Received: from lucidpixels.com ([66.45.37.187]:4488 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S261237AbVFPJZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 05:25:04 -0400
Date: Thu, 16 Jun 2005 05:24:59 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Michael Heyse <mhk@designassembly.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
In-Reply-To: <42B14415.5060105@designassembly.de>
Message-ID: <Pine.LNX.4.63.0506160523190.6459@p34>
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
 <42B14415.5060105@designassembly.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan followed up with me but we did not reach any conclusion as to what 
was causing it to crash.  The main way I got it to crash was dd 
if=/dev/hde (root drive) of=/nfs/file.img bs=1M, I have not had any issues 
as far as copying files and such.  For you, is it on a particular box or 
boxes, have you tried copying the other direction?  I use NFS over UDP btw 
(v3).

# mount
mount:/disk/1 on /remote/1 type nfs 
(rw,hard,intr,nfsvers=3,addr=192.168.168.253)


On Thu, 16 Jun 2005, Michael Heyse wrote:

> Hi Justin and others,
>
> did you manage to resolve this problem? I'm also experiencing apparantly NFS-related crashes (kernel
> hangs after a couple of seconds up to minutes, no syslog entries, nothing at all works any more)
> using 2.6.11.10 and NFS V3 over TCP, standard r/wsizes, ext3 on a RAID5 array. Is this possibly
> arch- or otherwise hardware-dependent? The NFS server works fine on my P4 on ASUS P4P800 board,
> while it crashes my EPIA Board (VIA C3) using the same software configuration. Other network
> applications run fine (as a workaround I'm using samba right now instead of nfs), so I don't think
> my hardware is broken.
>
> Thanks,
> Michael
>
