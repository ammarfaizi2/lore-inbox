Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUCHTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUCHTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:55:59 -0500
Received: from [203.122.12.28] ([203.122.12.28]:35206 "EHLO localhost")
	by vger.kernel.org with ESMTP id S261159AbUCHTz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:55:58 -0500
Date: Tue, 9 Mar 2004 01:26:00 +0530
From: Balram Adlakha <balram_a@ftml.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1
Message-ID: <20040308195600.GA3155@balram.gotdns.org>
References: <20040308174109.GA784@balram.gotdns.org> <20040308194749.GJ23525@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308194749.GJ23525@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 08:47:49PM +0100, Jens Axboe wrote:
> On Mon, Mar 08 2004, Balram Adlakha wrote:
> > Was the DMA patch for CDROMREADAUDIO reading? I don't seem any speed
> > increase while ripping with cdparanoia.
> 
> If your CPU was fast enough you will not see a speed increase, you
> should see system time go way down though. So try and time cdparanoia
> rip + encode session instead, that way you'll be using your CPU for
> something worthwhile while ripping the data (you'll be doing that if you
> use grip, for instance).
> 
> -- 
> Jens Axboe

Yeah it does work, system time is less than one second. Thanks a lot for
the patch.
