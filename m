Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281232AbRKTTCn>; Tue, 20 Nov 2001 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281225AbRKTTCe>; Tue, 20 Nov 2001 14:02:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4618 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281242AbRKTTCM>;
	Tue, 20 Nov 2001 14:02:12 -0500
Date: Tue, 20 Nov 2001 20:01:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Currie <billc@wirelessmatrixcorp.com>
Cc: linux-kernel@vger.kernel.org, lnz@dandelion.com
Subject: Re: DAC960 oops
Message-ID: <20011120200144.W31820@suse.de>
In-Reply-To: <20011119114446.A15561@wirelessmatrixcorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011119114446.A15561@wirelessmatrixcorp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19 2001, Bill Currie wrote:
> I'm trying to get a DS20 with a Mylex DAC960 up-and-running (boots just fine
> off the ide drive:) but when I modprobe DAC960, I get the following oops
> (while ksymoops is moaning about symbols etc, I got the symbols from the exact
> kernel running (infact, I think it's /still/ running:)):

DAC960 calls blk_cleanup_queue on a un-initialized queue, tell Leonard.

-- 
Jens Axboe

