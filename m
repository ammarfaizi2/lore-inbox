Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTE0OXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTE0OXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:23:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263637AbTE0OXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:23:52 -0400
Date: Tue, 27 May 2003 07:36:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <20030527065436.GX845@suse.de>
Message-ID: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Jens Axboe wrote:
> 
> Here's something ridicolously simple, that just wont start a new tag if
> the oldest tag is older than 100ms. Clearly nothing for submission, but
> it gets the point across.

Yes, I think something like this should work very well.

In fact, it might fit in very well indeed with AS - and in general it
might be a good idea to have some nice interface for the IO scheduler to
give this kind of ordering hints down to the hardware.

		Linus

