Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbSLPJaT>; Mon, 16 Dec 2002 04:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266462AbSLPJaT>; Mon, 16 Dec 2002 04:30:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266431AbSLPJaS>; Mon, 16 Dec 2002 04:30:18 -0500
Date: Mon, 16 Dec 2002 01:39:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove error message on illegal ioctl
In-Reply-To: <20021216091615.GQ11892@suse.de>
Message-ID: <Pine.LNX.4.44.0212160138480.1317-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2002, Jens Axboe wrote:
>
> Your non-root user still has to be able to open the cdrom.

Why not just make this all use the "quiet" flag, and make the ioctl's
always set it. That's what it's there for.

		Linus

