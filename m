Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUAMLAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUAMLAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:00:32 -0500
Received: from [212.239.226.101] ([212.239.226.101]:23936 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264278AbUAMLAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:00:30 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Tue, 13 Jan 2004 12:00:16 +0100
User-Agent: KMail/1.5.4
Cc: Kiko Piris <kernel@pirispons.net>, Bart Samwel <bart@samwel.tk>,
       linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <200401121409.44187.lkml@kcore.org> <20040112140238.GG24638@suse.de>
In-Reply-To: <20040112140238.GG24638@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131200.16025.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 15:02, Jens Axboe wrote:
> bo is accounted when io is actually put on the pending queue for the
> disk, so they really do go hand in hand. So you should use block_dump to
> find out why.

It's nearly always reiserfs that causes the disk to spin up. Also, I'm seeting 
the harddisk led light up every 5-7 seconds :-( weird.

Jan
-- 
I love you, not only for what you are, but for what I am when I am with you.
		-- Roy Croft

