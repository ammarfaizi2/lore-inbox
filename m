Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276285AbRJBShu>; Tue, 2 Oct 2001 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276529AbRJBShn>; Tue, 2 Oct 2001 14:37:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54281 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276512AbRJBShS>; Tue, 2 Oct 2001 14:37:18 -0400
Subject: Re: partition table read incorrectly
To: wichert@cistron.nl (Wichert Akkerman)
Date: Tue, 2 Oct 2001 19:42:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
In-Reply-To: <20011002202934.G14582@wiggy.net> from "Wichert Akkerman" at Oct 02, 2001 08:29:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oUUf-0005Xw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I seem to run into a weird problem. LVM refused to work properly,
> after a "vgscan" command "vgchange -a y" would still complain
> that things weren't consistent and I got a messages about an
> I/O error on 08:11.

Does it complain about wrong block sizes ?

> Interestingly my sdb does not have any partitions since it's one
> big PV, and fdisk agrees with me on that. However the kernel
> seems to thing I do have a partition there and as a result LVM
> seems to get somewhat confused.

The partition code will look for tables. That bit is fine

The exact error would be good too
