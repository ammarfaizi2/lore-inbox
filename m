Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVACTcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVACTcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVACTcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:32:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12256 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261508AbVACTcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:32:08 -0500
Date: Mon, 3 Jan 2005 20:28:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103192844.GA29678@suse.de>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03 2005, Bill Davidsen wrote:
> SCSI command filtering - while I totally support the idea (and always
> have), I miss running cdrecord as a normal user. Multisession doesn't work
> as a normal user (at least if you follow the man page) because only root
> can use -msinfo. There's also some raw mode which got a permission denied,
> don't remember as I was trying something not doing production stuff.

So look at dmesg, the kernel will dump the failed command. Send the
result here and we can add that command, done deal. 2.6.10 will do this
by default.

-- 
Jens Axboe

