Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVC0Ibf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVC0Ibf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVC0Ibf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:31:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:57801 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261450AbVC0Ibd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:31:33 -0500
Date: Sun, 27 Mar 2005 10:31:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: INITRAMFS: junk in compressed archive
In-Reply-To: <d24rad$378$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0503271030530.22393@yvahk01.tjqt.qr>
References: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local>
 <1111762170.7238.3.camel@FC3-bernhard-1.acousta.local> <d24rad$378$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any size-limit on initramfs image? I found out that after
>> reducing the image size it is loaded & /init executed as expected...
>
>Kernel + compressed initramfs + uncompressed initramfs must fit in memory at
>the same time.

This sounds like kernel + squashfs-as-"oldstyle"-initrd is better. At least if 
you can live with a read-only fs on startup.



Jan Engelhardt
-- 
No TOFU for me, please.
