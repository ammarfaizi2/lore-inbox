Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVHYPyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVHYPyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHYPyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:54:03 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:51814 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932198AbVHYPyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:54:01 -0400
Date: Thu, 25 Aug 2005 17:54:00 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050825155400.GB20557@harddisk-recovery.com>
References: <200508251534.j7PFY11g024729@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508251534.j7PFY11g024729@ms-smtp-01.rdc-nyc.rr.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please please pretty please get an RFC compliant mailer that
generates "In-Reply-To" and preferable even "References" headers? Right
now every mail you write starts a new thread instead of referencing to
the previous one. See http://lkml.org/lkml/2005/8/25/180/ to see what I
mean.

On Thu, Aug 25, 2005 at 11:34:01AM -0400, robotti@godmail.com wrote:
> 
>    >On Thu, Aug 25, 2005 at 12:35:22AM -0400, robotti@xxxxxxxxxxx wrote:
>    >I don't know, because tar is probably more widely used and
>    >consequently people are more familiar with how to use it.
>    >>As I said before, the cpio format is cleaner/easier to parse in the
>    >>kernel. Everyone has cpio probably so using tar isn't necessary.
> 
> Cpio is perhaps as available as tar, but it's not as used as tar.

So? Firefox is as available as IE, but it's not as used as IE. Does
that make IE better?

> Unless tar would be inordinately larger than a cpio implementation
> (I can't imagine, but I'm not a coder!) I would prefer it.

You have been told a couple of times that a tar implementation in
kernel is indeed larger than a cpio implementation. If you're not a
coder, just believe the coders.

> If initramfs replaces the old initrd method it should have something
> as a filesystem that's robust and inspires confidence like ext2.

The simplicity of ramfs inspires more than enough confidence.

> I know generally an initrd is used to load modules and prepare
> the installation of a Linux system, so it doesn't require much
> in a filesystem.

An initramfs can be used to do the same, but doesn't have the overhead
of a block device. IOW: it requires even *less* than an initrd.

> But, it can also be used to hold and run a complete Linux system,
> so a more robust filesystem (tmpfs) is useful. 

What makes you think tmpfs is more robust than ramfs? What do you mean
with a "robust filesystem"?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
