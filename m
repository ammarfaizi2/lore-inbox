Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312825AbSCVUJP>; Fri, 22 Mar 2002 15:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSCVUJE>; Fri, 22 Mar 2002 15:09:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:3716 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312825AbSCVUIt>; Fri, 22 Mar 2002 15:08:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 22 Mar 2002 12:13:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: David Schwartz <davids@webmaster.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7, IDE, 'handler not null', 'kernel timer added twice'
In-Reply-To: <3C9B0E88.70305@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203221209580.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Martin Dalecki wrote:

> Davide Libenzi wrote:
>
> >
> >
> > name			value		min		max		mode
> > ----			-----		---		---		----
> > acoustic                0               0               254             rw
> > address                 0               0               2               rw
> > bios_cyl                2495            0               65535           rw
> > bios_head               255             0               255             rw
> > bios_sect               63              0               63              rw
> > bswap                   0               0               1               r
> > current_speed           0               0               69              rw
> > failures                0               0               65535           rw
> > ide_scsi                0               0               1               rw
> > init_speed              0               0               69              rw
> > io_32bit                0               0               3               rw
> > keepsettings            0               0               1               rw
> > lun                     0               0               7               rw
> > max_failures            1               0               65535           rw
> > multcount               16              0               16              rw
> > nice1                   1               0               1               rw
>
> Please try to set this nice1 stuff to 0 I would be glad
> to know whatever this helps.

I have these messages at boot. I'll rebuild the kernel with nice1
defaulted to 0 and let's see what happens. Anyway it's a good tip, i've
the cdrom on the same ide interface on my hd ...



- Davide


