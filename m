Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUCHTtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUCHTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:49:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8874 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261168AbUCHTry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:47:54 -0500
Date: Mon, 8 Mar 2004 20:47:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Balram Adlakha <balram_a@ftml.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1
Message-ID: <20040308194749.GJ23525@suse.de>
References: <20040308174109.GA784@balram.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308174109.GA784@balram.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08 2004, Balram Adlakha wrote:
> Was the DMA patch for CDROMREADAUDIO reading? I don't seem any speed
> increase while ripping with cdparanoia.

If your CPU was fast enough you will not see a speed increase, you
should see system time go way down though. So try and time cdparanoia
rip + encode session instead, that way you'll be using your CPU for
something worthwhile while ripping the data (you'll be doing that if you
use grip, for instance).

-- 
Jens Axboe

