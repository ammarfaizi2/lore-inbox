Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVCVF2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVCVF2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVCVFYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:24:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:4872 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262396AbVCVFVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:21:05 -0500
Date: Tue, 22 Mar 2005 06:20:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050322052043.GI30052@alpha.home.local>
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321190044.GD1390@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel,

On Mon, Mar 21, 2005 at 08:00:44PM +0100, Pavel Machek wrote:
 
> Perhaps squashfs is good enough improvement over cramfs... But I'd
> like those 4Gb limits to go away.

Well, squashfs is an *excellent* filesystem with very high compression ratios
and high speed on slow I/O devices such as CDs. I now use it to store my root
FS in initrd, and frankly, having a fully functionnal OS in an image as small
as 7 MB is "a good enough improvement over cramfs".

If the 4 GB limit goes away one day, I hope it will not increase overall
image size significantly, because *this* would then become a regression.
Perhaps it would simply need to be a different version and different format
(eg: squashfs v3) just as we had ext, then ext2, or jffs then jffs2, etc...

Cheers,
Willy

