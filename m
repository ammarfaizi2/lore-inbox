Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUCOWlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbUCOWlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:41:20 -0500
Received: from smtp03.web.de ([217.72.192.158]:29466 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262839AbUCOWk3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:40:29 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm2
Date: Mon, 15 Mar 2004 23:40:10 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403152157.02051.thomas.schlichter@web.de> <20040315131852.3fd9cd93.akpm@osdl.org>
In-Reply-To: <20040315131852.3fd9cd93.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403152340.11578.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. März 2004 22:18 schrieb Andrew Morton:
> Thomas Schlichter <thomas.schlichter@web.de> wrote:
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

[patch snipped]

Yeah, this fixes it...
Thanks!

Regards
   Thomas

