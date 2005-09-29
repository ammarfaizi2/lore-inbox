Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVI2UHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVI2UHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVI2UHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:07:37 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:32165 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030239AbVI2UHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:07:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 29 Sep 2005 21:07:29 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Dave Jones <davej@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <20050929200252.GA31516@redhat.com>
Message-ID: <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Dave Jones wrote:
> On Thu, Sep 29, 2005 at 07:03:05AM -0400, Jeff Garzik wrote:
>  > Just updated my KHGtG to include the latest goodies available in 
>  > git-core, the Linux kernel standard SCM tool:
>  > 
>  > 	http://linux.yyz.us/git-howto.html
>  > 
>  > Several changes in git-core have made working with git a lot easier, so 
>  > be sure to re-familiarize yourself with the development process.
>  > 
>  > Comments, corrections, and notes of omission welcome.  This document 
>  > mainly reflects my typical day-to-day git activities, and may not be 
>  > very applicable outside of kernel work.
> 
> You wrote..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ rsync -a --verbose --stats --progress \
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>   .git/
> 
> Could be just..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ git pull

That is not actually the same.  "git pull" for example will not download 
Linus' tags whilst the rsync would get everything.

> Likewise, in the next section, git pull doesn't need an argument
> if pulling from the repo it cloned.

Now that is definitely correct.  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
