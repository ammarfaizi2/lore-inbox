Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131641AbRARNCl>; Thu, 18 Jan 2001 08:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135368AbRARNCc>; Thu, 18 Jan 2001 08:02:32 -0500
Received: from nas1-19.wms.club-internet.fr ([213.44.28.19]:17648 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S131641AbRARNC2>;
	Thu, 18 Jan 2001 08:02:28 -0500
Message-Id: <200101181301.OAA18768@microsoft.com>
Subject: Re: Linux not adhering to BIOS Drive boot order?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Tim Fletcher <tim@parrswood.manchester.sch.uk>
Cc: David Balazic <david.balazic@uni-mb.si>,
        Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0101181130590.23287-100000@pine.parrswood.manchester.sch.uk>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 18 Jan 2001 14:01:42 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jan 2001 11:35:57 +0000, Tim Fletcher wrote:

> This is when devfs comes into its own, as the disks are refered to by
> their device/controller id not by the /dev/sd{a,b,c,etc} numbering, hence
> when one fails the others don't change. Also I think the kernel autodetect
> code for scsi devices will deal with this case, but I'm not sure.


'would be great to use driver name, e.g. something like
/dev/scsi/advansys/... (I don't remember devfs naming scheme)

Xav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
