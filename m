Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRLXWLT>; Mon, 24 Dec 2001 17:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRLXWLI>; Mon, 24 Dec 2001 17:11:08 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:61316 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282778AbRLXWK7>; Mon, 24 Dec 2001 17:10:59 -0500
Date: Mon, 24 Dec 2001 17:14:11 -0500
To: Jens Axboe <axboe@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011224171411.A260@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011224180244.C1241@suse.de>; from axboe@suse.de on Mon, Dec 24, 2001 at 06:02:44PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 06:02:44PM +0100, Jens Axboe wrote:
> 
> I would suspect that, do you get any kernel messages?

When the machine gets in this state, it won't save any files,
so kern.log doesn't have anything after the initial boot message.

> Please send ps -eo cmd,wchan info for a hung machine.
> 
> -- 
> Jens Axboe

Strangely (to me anyway), when dbench 32 hangs the machine,
ps will not print anything.  vmstat will continue it's 8 
second cycle though.

-- 
Randy Hron

