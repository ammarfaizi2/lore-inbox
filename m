Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUAMLCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUAMLCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:02:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65459 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264284AbUAMLBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:01:20 -0500
Date: Tue, 13 Jan 2004 12:01:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan De Luyck <lkml@kcore.org>
Cc: Kiko Piris <kernel@pirispons.net>, Bart Samwel <bart@samwel.tk>,
       linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Message-ID: <20040113110110.GA6711@suse.de>
References: <3FFFD61C.7070706@samwel.tk> <200401121409.44187.lkml@kcore.org> <20040112140238.GG24638@suse.de> <200401131200.16025.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401131200.16025.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13 2004, Jan De Luyck wrote:
> On Monday 12 January 2004 15:02, Jens Axboe wrote:
> > bo is accounted when io is actually put on the pending queue for the
> > disk, so they really do go hand in hand. So you should use block_dump to
> > find out why.
> 
> It's nearly always reiserfs that causes the disk to spin up. Also, I'm
> seeting the harddisk led light up every 5-7 seconds :-( weird.

Does 2.6 laptop mode patch even include the necessary reiser changes to
make this work properly?

-- 
Jens Axboe

