Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUACM0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUACM0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:26:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15512 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262750AbUACM0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:26:20 -0500
Date: Sat, 3 Jan 2004 13:26:14 +0100
From: Jens Axboe <axboe@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Long pauses (IO?) whilst ripping DVDs
Message-ID: <20040103122614.GW5523@suse.de>
References: <2950000.1073111086@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2950000.1073111086@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Martin J. Bligh wrote:
> Start transcode in one window, doing something like:
> "transcode -i /dev/hdc -x dvd -U file_name -y divx4"
> on a DVD ... probably pretty CPU intensive as well as IO.
>
> Now do ls in another window ... hangs for about 5 seconds before
> giving any output ;-( Anyone else seeing that? I do get a lot of
> "*** libdvdread: CHECK_VALUE failed in nav_read.c:202 ***"
> messages as well ... but I always seem to get those from DVD stuff.

DMA or PIO? vmstat info would be very handy here.

-- 
Jens Axboe

