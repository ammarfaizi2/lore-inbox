Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275448AbRJATmM>; Mon, 1 Oct 2001 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275449AbRJATmC>; Mon, 1 Oct 2001 15:42:02 -0400
Received: from ns.caldera.de ([212.34.180.1]:17863 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S275448AbRJATln>;
	Mon, 1 Oct 2001 15:41:43 -0400
Date: Mon, 1 Oct 2001 21:42:00 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org, hch@ns.caldera.de
Subject: Re: [HANG] Checking root filesystem and then...
Message-ID: <20011001214200.A23514@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Maurice Volaski <mvolaski@aecom.yu.edu>,
	linux-kernel@vger.kernel.org, hch@ns.caldera.de
In-Reply-To: <a05100310b7de4e632992@[129.98.91.150]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a05100310b7de4e632992@[129.98.91.150]>; from mvolaski@aecom.yu.edu on Mon, Oct 01, 2001 at 03:39:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 03:39:36PM -0400, Maurice Volaski wrote:
> Running on a Netfinity x340 box (single PIII, ServRAID card and 
> Adaptec 29160LP card, boot disk is ext2 and is attached to the 
> ServRAID card), a stock 2.4.10 kernel gets to the point of "Checking 
> root filesystem" and the system simply stops dead in its tracks.
> 
> It stops at the line initlog -c "fsck -T -a $fsckoptions /" If I 
> remove the "initlog", it still stops. If I remove the "fsck", it 
> stops at the next line (mount -n -o remount, rw /)!
> 
> I have systematically tried a number of different kernels and have 
> discovered that
> 
> 2.4.10-pre5 works
> 2.4.10-pre6 hangs
> 
> 2.4.9-ac7 works
> 2.4.9-ac8 hangs

2.4.9-ac17+ should work again, could you test it please?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
