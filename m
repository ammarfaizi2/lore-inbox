Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUBTXop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUBTXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:44:45 -0500
Received: from mid-2.inet.it ([213.92.5.19]:37812 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S261369AbUBTXon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:44:43 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Fri, 20 Feb 2004 21:22:43 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402192234.53855.cova@ferrara.linux.it> <20040219162102.0b699698.akpm@osdl.org>
In-Reply-To: <20040219162102.0b699698.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200402202122.43853.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 01:21, venerdì 20 febbraio 2004, Andrew Morton ha scritto:

> > Feb 19 22:23:15 kefk kernel:         aic7850: Single Channel A, SCSI
> > Id=7, 3/253 SCBs
> >
> > <<<<<<<<<<<<<<<2.6.3-mm1 hangs here
>
> Are you able to get a sysrq-T or sysrq-P trace?

I've just tried, but the system seems completely hung. The only activity is 
from scsi cdrom device, that blinks a light every 20/30 seconds, more or 
less. Even Caps/Num/Scroll lock keyboards led are frozen.

(tried also with mm2)
>
> > I've also noticed (only with 2.6.3-mm1) a "PCI BIOS passed non existent
> > PCI BUS 0!" message when it probes ICH5, i.e.
>
> Could be an acpi thing.  If you have time, could you try
>
> 	patch -p1 -R < bk-acpi.patch
>
> and see if that helps?

At this moment I can't reach kernel.org, some connectivity issue over the 
ocean, I suppose :)
I'll try again in few hours.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
