Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbUCOVTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUCOVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:19:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262769AbUCOVS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:18:26 -0500
Date: Mon, 15 Mar 2004 22:18:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Schlichter <thomas.schlichter@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040315211818.GF660@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403152157.02051.thomas.schlichter@web.de> <20040315131852.3fd9cd93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315131852.3fd9cd93.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15 2004, Andrew Morton wrote:
> Thomas Schlichter <thomas.schlichter@web.de> wrote:
> >
> > ith 2.6.4-mm2 I get following badness on boot:
> > 
> > Badness in as_insert_request at drivers/block/as-iosched.c:1513
> > Call Trace:
> >  [<c022e326>] as_insert_request+0x166/0x190
> >  [<c0225af8>] __elv_add_request+0x28/0x60
> >  [<c0228b9b>] __make_request+0x47b/0x540
> >  [<c0228d75>] generic_make_request+0x115/0x1d0
> >  [<c011efd0>] autoremove_wake_function+0x0/0x40
> >  [<c0228e80>] submit_bio+0x50/0xf0
> >  [<c0162f58>] __bio_add_page+0x88/0x110
> 
> Someone got his bitmasks and bitshifts mixed up again ;)

Fudge, thanks Andrew.

-- 
Jens Axboe

