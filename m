Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUCHJj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUCHJj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:39:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61090 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262341AbUCHJjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:39:24 -0500
Date: Mon, 8 Mar 2004 10:39:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Justin Piszcz <jpiszcz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.3 CD Burning Problems, Looks Kernel Realted
Message-ID: <20040308093921.GR23525@suse.de>
References: <Law10-F224x1h7AzQpq0004dd3c@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F224x1h7AzQpq0004dd3c@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07 2004, Justin Piszcz wrote:
> Not only cdrdao, but cdrecord as well only see's the SECOND IDE channel.
> Why is this?
> 
> I have my main disk on a Promise board incase anyone wonders what that is 
> (hde).
> 
> $ ./cdrecord dev=ATAPI --scanbus
> Cdrecord-Clone 2.01a26 (i686-pc-linux-gnu) Copyright (C) 1995-2004 J?rg 
> Schilling
> scsidev: 'ATAPI'
> devname: 'ATAPI'
> scsibus: -2 target: -2 lun: -2
> Warning: Using ATA Packet interface.
> Warning: The related libscg interface code is in pre alpha.
> Warning: There may be fatal problems.
> Using libscg version 'schily-0.7'.
> scsibus0:
>        0,0,0     0) 'PLEXTOR ' 'CD-R   PX-W1210A' '1.10' Removable CD-ROM
>        0,1,0     1) 'TOSHIBA ' 'DVD-ROM SD-M1712' '1004' Removable CD-ROM
>        0,2,0     2) *
>        0,3,0     3) *
>        0,4,0     4) *
>        0,5,0     5) *
>        0,6,0     6) *
>        0,7,0     7) *

Why are you reporting it here and not to the maintainer of above tool?
And why are you scanning the bus, when you know perfectly well where you
devices are attached? dev=/dev/hdX and be done with it.

-- 
Jens Axboe

