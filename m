Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWCQUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWCQUj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWCQUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:39:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10248 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932188AbWCQUj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:39:26 -0500
Date: Fri, 17 Mar 2006 21:39:04 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Phillip Lougher <phillip@lougher.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060317203904.GE21493@w.ods.org>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441AF118.7000902@garzik.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 17, 2006 at 12:25:44PM -0500, Jeff Garzik wrote:
> I have two routers, ADM5120-based Edimax and LinkSys WRT54G v5, both of 
> which have a mere 2MB of flash, and both use SquashFS to maximize that 
> space.  And both are el cheapo, slow embedded processors that run far 
> slower than 300Mhz.  I look askance at anyone who wants to make an 
> arbitrary filesystem design decision imposing tons of bytesex upon these 
> lowly devices.

100% agreed. I love squashfs because it's tiny and efficient, and I
would not want to see it getting heavy.

BTW, has someone tried to port LZMA to squashfs ? I tried so on
bzImage + initramfs, and got something like a 27% smaller image.
That would mean about 500 kB on a 2 MB image.

> 	Jeff

Willy

