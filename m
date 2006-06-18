Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWFRWpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFRWpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWFRWpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:45:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:39222 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750718AbWFRWpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:45:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/IhHn8WuKOMu7NtIl+3hKE1pW9QUBgNpoX31IxzaybyalaLA0SWlBLiXBxl0MkM7QAlrDO3Q3PiLltUxoZbfD/EsPIMSOGwNVeLhsWsJxOV6zKU0HxEs+hp/ggcu+UHtQjozSY7LFA2jI13yGc25ITFGyNu72wU/P93C2OPi9A=
Message-ID: <6bffcb0e0606181545v72926ffas88561f9532030cfb@mail.gmail.com>
Date: Mon, 19 Jun 2006 00:45:16 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20060618221343.GA20277@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060618221343.GA20277@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 19/06/06, Greg KH <gregkh@suse.de> wrote:
[snip]
> I've posted all of these patches before, but if people really want to look at them, they can be found at:
>         http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
>

devfs-remove-devfs_fs_kernel.h.patch doesn't apply clean.

[michal@ltg01-fedora linux-work2]$ quilt push devfs-feature-removal.patch
Applying patch patches/devfs-die-die-die.patch
patching file fs/Makefile
patching file fs/compat_ioctl.c
[..]
patching file drivers/video/fbmem.c
patching file fs/coda/psdev.c
patching file fs/partitions/check.c
Hunk #1 FAILED at 320.
1 out of 1 hunk FAILED -- rejects in file fs/partitions/check.c
patching file include/linux/devfs_fs_kernel.h
Patch patches/devfs-remove-devfs_remove.patch does not apply (enforce with -f)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
