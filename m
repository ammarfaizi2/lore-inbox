Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbSJ3O2r>; Wed, 30 Oct 2002 09:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264693AbSJ3O2r>; Wed, 30 Oct 2002 09:28:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50832 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264692AbSJ3O2q>;
	Wed, 30 Oct 2002 09:28:46 -0500
Date: Wed, 30 Oct 2002 15:35:02 +0100
From: Jens Axboe <axboe@suse.de>
To: merlin hughes <merlin@merlin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:819 with 2.5.44-ac5
Message-ID: <20021030143502.GK3416@suse.de>
References: <20021030141812.BF07786921@primary.mx.nitric.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030141812.BF07786921@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30 2002, merlin hughes wrote:
> Hi,
> 
> Tyan Tiger S2466-4M, 2xAthlon MP, Adaptec 29160, Adaptec 2940u2w,
> software RAID 5, gcc 2.95.4. The core drives are on the 29160. Works
> fine under 2.4.19.
> 
> 2.5.44 panics during boot with SCSI problems; I didn't catch what the
> error was.
> 
> 2.5.44-ac5 boots but bugs after a few seconds.
> 
> Attached: config, syslog, lspci (under 2.4.19)
> 
> Oct 28 12:36:09 badb kernel: Incorrect number of segments after building list
> Oct 28 12:36:09 badb kernel: counted 2, received 1
> Oct 28 12:36:09 badb kernel: req nr_sec 8, cur_nr_sec 8

Please try 2.5.44-BK and see if that works, James fixed this one.

-- 
Jens Axboe

