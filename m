Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQJ3Xcx>; Mon, 30 Oct 2000 18:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbQJ3Xcn>; Mon, 30 Oct 2000 18:32:43 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2053 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129162AbQJ3Xc1>; Mon, 30 Oct 2000 18:32:27 -0500
Date: Mon, 30 Oct 2000 23:32:23 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: / on ramfs, possible?
In-Reply-To: <39FE03B2.E3E12A23@transmeta.com>
Message-ID: <Pine.LNX.4.21.0010302329140.16675-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, H. Peter Anvin wrote:

> Pardon?!  This doesn't make any sense...
> 
> The question was: how do switch from the initrd to using the ramfs as /? 
> Using pivot_root should do it (after the pivot, you can of course nuke
> the initrd ramdisk.)

My question is: What do you want to do that for? You can nuke the initrd
ramdisk, but you can't drop the rd.c code, or ll_rw_blk.c code, etc. So
why not just keep your root filesystem in the initrd where it started off?

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
