Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSLPLtW>; Mon, 16 Dec 2002 06:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSLPLtW>; Mon, 16 Dec 2002 06:49:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53458 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262303AbSLPLtV>;
	Mon, 16 Dec 2002 06:49:21 -0500
Date: Mon, 16 Dec 2002 12:56:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove error message on illegal ioctl
Message-ID: <20021216115658.GR11892@suse.de>
References: <20021216091615.GQ11892@suse.de> <Pine.LNX.4.44.0212160138480.1317-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212160138480.1317-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16 2002, Linus Torvalds wrote:
> 
> 
> On Mon, 16 Dec 2002, Jens Axboe wrote:
> >
> > Your non-root user still has to be able to open the cdrom.
> 
> Why not just make this all use the "quiet" flag, and make the ioctl's
> always set it. That's what it's there for.

Yes that would be fine. I just don't want uniform packets to be silently
dropped, that makes debugging a problem with a drive pretty much
impossible.

-- 
Jens Axboe

