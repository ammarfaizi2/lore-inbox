Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTICJim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTICJim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:38:42 -0400
Received: from tench.street-vision.com ([212.18.235.100]:44684 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261772AbTICJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:38:40 -0400
Subject: Re: devfs to be obsloted by udev?
From: Justin Cormack <justin@street-vision.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309022219.02549.bzolnier@elka.pw.edu.pl>
References: <3F54A4AC.1020709@wmich.edu> 
	<200309022219.02549.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 03 Sep 2003 10:38:48 +0100
Message-Id: <1062581929.30060.197.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 21:19, Bartlomiej Zolnierkiewicz wrote:
> 
> initramfs

which seems to have been postponed to 2.7.


> On Tuesday 02 of September 2003 16:09, Ed Sweetman wrote:
> > It appears that devfs is to be replaced by the use of udev in the not so
> > distant future.  I'm not sure how it's supposed to replace a static /dev
> > situaton seeing as how it is a userspace daemon.  Is it not supposed to
> > replace /dev even when it's completed?  I dont see the real benefit in
> > having two directories that basically give the same info.  Right now we
> > have something like that with proc and sysfs although not everything in
> > proc makes sense to be in sysfs and both are virtual fs's where as /dev
> > is a static fs on the disk that takes up space and inodes and includes
> > way too many files that a system may not use.  If udev is to take over
> > the job of devfs, how will modules and drivers work that require device
> > files to be present in order to work since undoubtedly the udev daemon
> > will have to wait until the kernel is done booting before being run.
> >
> > I'm just not following how it is going to replace devfs and thus why
> > devfs is being abandoned as mentioned in akpm's patchset. Or as it
> > seems, already has been abandoned.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


