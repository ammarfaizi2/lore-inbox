Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTL2Qsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTL2Qsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:48:46 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:65284 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S263638AbTL2Qso convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:48:44 -0500
Date: Tue, 30 Dec 2003 00:47:06 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't mount USB partition as root
In-Reply-To: <20031229173853.A32038@beton.cybernet.src>
Message-ID: <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com>
References: <20031229173853.A32038@beton.cybernet.src>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/30/2003
 12:48:39 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/30/2003
 12:48:41 AM,
	Serialize complete at 12/30/2003 12:48:41 AM
Content-Transfer-Encoding: 8BIT
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You'll need to load the usb modules using initrd ramdisk, then switch root
to the usb device to continue booting the system.


Thanks,
Jeff
[ jchua@fedex.com ]

On Mon, 29 Dec 2003, [iso-8859-2] Karel Kulhavý wrote:

> Hello
>
> I tried to boot Linux 2.6.0 kernel with option root=/dev/sda1 using Grub.
> The kernel otherwise works, mounts the sda1 partition (XFS) OK.
> When I boot the kernel with root=/dev/sda1 instead of root=/dev/hda4,
> I get "can't mount root VFS, kernel panic" or something like that.
>
> Is it possible to boot kernel with root from /dev/sda1 (USB)?
> partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
> Tried also switching on and off hotplugging in kernel and it didn't help.
>
> Cl<
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
