Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSANRGW>; Mon, 14 Jan 2002 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSANRGM>; Mon, 14 Jan 2002 12:06:12 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:41639 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287720AbSANRF6>; Mon, 14 Jan 2002 12:05:58 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 14 Jan 2002 08:32:28 -0800
Message-Id: <200201141632.IAA15002@adam.yggdrasil.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.5.2-pre11/drivers/block/loop.c -- garbage reads
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This does not affect the patch that I posted, but I wish to
update one remark that I made:

>         By the way, there are plenty of other problems with
> loop.c, such as the fact that it hangs my note book computer
> in "disk I/O" (presumably to /dev/loop/0) every time it boots,

	I must apologize for suggesting that that was another loop.c
bug.  It turns out that this is a devfsd quirk that disappeared when I
updated to the latest devfsd (it has to do with recent kernels
using a different test to determine which processes are children of
devfsd).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
