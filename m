Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTIBUSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTIBUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:18:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26825 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263915AbTIBUSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:18:20 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: devfs to be obsloted by udev?
Date: Tue, 2 Sep 2003 22:19:02 +0200
User-Agent: KMail/1.5
Cc: greg@kroah.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F54A4AC.1020709@wmich.edu>
In-Reply-To: <3F54A4AC.1020709@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309022219.02549.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


initramfs

On Tuesday 02 of September 2003 16:09, Ed Sweetman wrote:
> It appears that devfs is to be replaced by the use of udev in the not so
> distant future.  I'm not sure how it's supposed to replace a static /dev
> situaton seeing as how it is a userspace daemon.  Is it not supposed to
> replace /dev even when it's completed?  I dont see the real benefit in
> having two directories that basically give the same info.  Right now we
> have something like that with proc and sysfs although not everything in
> proc makes sense to be in sysfs and both are virtual fs's where as /dev
> is a static fs on the disk that takes up space and inodes and includes
> way too many files that a system may not use.  If udev is to take over
> the job of devfs, how will modules and drivers work that require device
> files to be present in order to work since undoubtedly the udev daemon
> will have to wait until the kernel is done booting before being run.
>
> I'm just not following how it is going to replace devfs and thus why
> devfs is being abandoned as mentioned in akpm's patchset. Or as it
> seems, already has been abandoned.

