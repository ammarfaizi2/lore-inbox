Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTL2Tl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTL2Tl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:41:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12941 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263922AbTL2Tk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:40:58 -0500
Date: Mon, 29 Dec 2003 20:40:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Walt H <waltabbyh@comcast.net>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
Message-ID: <20031229194053.GM3086@suse.de>
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net> <3FEFDE4A.1030208@wmich.edu> <3FF0580C.5070604@comcast.net> <3FF06A26.8060609@wmich.edu> <3FF07F3E.2090405@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF07F3E.2090405@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29 2003, Walt H wrote:
> Ed Sweetman wrote:
> > check out test11-mm1's cdrom.c.  I think it'll make things clear.  I
> > just replaced the cdrom.c and ide-cd.h and ide-cd.c files in 2.6.0-mm1
> > with 2.6.0-test11-mm1's and things are working perfect.
> > 
> > 
> > 
> 
> Ed,
> 
> I can confirm that 2.6.0-mm2 fixes the tray lock issue. On my setup,
> the drive's capabilities are reported correctly as well. Haven't done
> serious testing yet, but I could at least blank a cd-rw :) yay!

It was a merge error in -mm1 that caused the problem.

-- 
Jens Axboe

