Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966390AbWKTWeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966390AbWKTWeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966409AbWKTWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:34:17 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:51591
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S966390AbWKTWeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:34:16 -0500
Date: Sun, 19 Nov 2006 22:41:06 -0800
From: Brad Boyer <flar@allandria.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: funaho@jurai.org, linux-mac68k@mac.linux-m68k.org, geert@linux-m68k.org,
       zippel@linux-m68k.org, linux-m68k@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove the broken BLK_DEV_SWIM_IOP driver
Message-ID: <20061120064106.GA25209@cynthia.pants.nu>
References: <20061120210654.GC31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120210654.GC31879@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 10:06:54PM +0100, Adrian Bunk wrote:
> The BLK_DEV_SWIM_IOP driver has:
> - already been marked as BROKEN in 2.6.0 three years ago and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.

Feel free to remove this one. It was never in a state that worked, but
was added to the tree anyway. I tried to fix it when I was given a
copy of the documentation, but it needed more work than I initially
expected. The initial version that was in the tree could only detect
the drives, and the only thing I added other than some bug fixes was
support for the eject ioctl. The read/write path in the driver is
missing the actual data transfer routines, and is therefore not in
a working state.

For the record, I believe the linux-mac68k list is dead.

	Brad Boyer
	flar@allandria.com

