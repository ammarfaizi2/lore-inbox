Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRA2Qvh>; Mon, 29 Jan 2001 11:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRA2QvR>; Mon, 29 Jan 2001 11:51:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16913 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129562AbRA2QvQ>;
	Mon, 29 Jan 2001 11:51:16 -0500
Date: Mon, 29 Jan 2001 17:51:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Nathan Black <NBlack@md.aacisd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bolck Device problem or Compaq Smart array 2 problem? kernel -2.4 .0+
Message-ID: <20010129175104.D23061@suse.de>
In-Reply-To: <8FED3D71D1D2D411992A009027711D67185B@md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8FED3D71D1D2D411992A009027711D67185B@md>; from NBlack@md.aacisd.com on Mon, Jan 29, 2001 at 11:44:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, Nathan Black wrote:
> It comes back with a command prompt. trying a "simple command... ps, ls
> it does not return. The hard disks(hardware raid) light up. But it seems
> like noone is home.
> It doesn't oops in the 2.4.1-pre11 or 10.
> That is a good thing.

Look where the ls etc hangs, do a ps -eo cmd,wchan and see if you can
catch it.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
