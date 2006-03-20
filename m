Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWCTVa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWCTVa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWCTVa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:30:28 -0500
Received: from xenotime.net ([66.160.160.81]:3271 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030370AbWCTVa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:30:27 -0500
Date: Mon, 20 Mar 2006 13:32:30 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Message-Id: <20060320133230.ae739f58.rdunlap@xenotime.net>
In-Reply-To: <20060320212338.GA11571@kroah.com>
References: <20060320212338.GA11571@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 13:23:38 -0800 Greg KH wrote:

> They are the same "delete devfs" patches that I submitted for 2.6.12 and
> 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
> and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
> no complaints about the fact that devfs was not able to be enabled
> anymore, and in fact, a lot of different subsystems have already been
> deleting devfs support for a while now, with apparently no complaints
> (due to the lack of users.)
> 
> It's also been over 8 months past the date when we said we would delete
> devfs from the kernel tree in the file,
> Documentation/feature-removal-schedule.txt, and over one and one half
> years since we publicly announced to the world that devfs would be
> removed from the kernel tree.  So, I think people have had plenty of
> advance notice that this was going to happen by now :)
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
> 
> I've posted all of these patches before, but if people really want to look at them, they can be found at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
> 
> Also, if people _really_ are in love with the idea of an in-kernel
> devfs, I have posted a patch that does this in about 300 lines of code,
> called ndevfs.  It is available in the archives if anyone wants to use
> that instead (it is quite easy to maintain that patch outside of the
> kernel tree, due to it only needing 3 hooks into the main kernel tree.)
> 
> thanks,
> 
> greg k-h
> 
> 
>  Documentation/DocBook/kernel-api.tmpl             |    5 
>  Documentation/filesystems/devfs/ChangeLog         | 1977 ---------------
>  Documentation/filesystems/devfs/README            | 1959 ---------------
>  Documentation/filesystems/devfs/ToDo              |   40 
>  Documentation/filesystems/devfs/boot-options      |   65 

More Documentation/ references to /devfs/i :

Changes
computone.txt
feature-removal-schedule.txt
initrd.txt
ioctl-number.txt
kernel-docs.txt
kernel-parameters.txt
README.DAC960


---
~Randy
