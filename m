Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUAYXIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUAYXIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:08:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36253 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265326AbUAYXH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:07:58 -0500
Date: Sun, 25 Jan 2004 23:07:56 +0000
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, bunk@fs.tum.de,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] show "Fusion MPT device support" menu only if BLK_DEV_SD
Message-ID: <20040125230756.GI11844@parcelfarce.linux.theplanet.co.uk>
References: <20040120232507.GC6441@fs.tum.de> <20040120233537.A23375@infradead.org> <20040120160346.7e466ad2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120160346.7e466ad2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 04:03:46PM -0800, Andrew Morton wrote:
> There's a hint in the config help:
> 
>           [2] In order enable capability to boot the linux kernel
>           natively from a Fusion MPT target device, you MUST
>           answer Y here! (currently requires CONFIG_BLK_DEV_SD)
> 
> But a kernel built with BLK_DEV_SD=n, FUSION=y builds and links OK.

This is one of the patches I have in my tree.  Andrew, shall I start
feeding all my Kconfig cleanups through you rather than through
kernel-janitors?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
