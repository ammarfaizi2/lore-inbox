Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130037AbRCAVLO>; Thu, 1 Mar 2001 16:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130016AbRCAVIL>; Thu, 1 Mar 2001 16:08:11 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:12229 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130020AbRCAVGe>; Thu, 1 Mar 2001 16:06:34 -0500
Message-ID: <3A9EB8BC.7E5D544D@coplanar.net>
Date: Thu, 01 Mar 2001 16:01:48 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Per Erik Stendahl <PerErik@onedial.se>
CC: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Unmounting and ejecting the root fs on shutdown.
In-Reply-To: <E44E649C7AA1D311B16D0008C73304460933B6@caspian.prebus.uppsala.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Erik Stendahl wrote:

>
> Nah, that looks too easy! ;-)
>
> > This might save everyone some pain:
> > from hdparm(8) man page (mine has some format
> > bugs, but you get the picture)
> >

> Is it true that the root fs is left mounted read-only? What is the
> rationale behind this? It seems to me that it would be better to
> completely unmount it and do whatever cleaning up is required (like
> cdrom_release()?). But I've been known to miss important issues before!
> :-)
>
> BTW, what would be the best way to determine which devices are cdrom
> devices? Looks like /proc/sys/dev/cdrom/info could be of use but what
> happens on a computer with more than one cdrom device?
>

Read about devfs option in 2.4 kernel.  it puts only devices that exist
into /dev/cdroms/cdrom0, dev/cdroms/cdrom1, etc.

and if hdparm works (and it must since redhat's installer ejects it's
cd when rebooting) and you still are looking for a solution, well
no comment.

