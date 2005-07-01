Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263291AbVGAJXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbVGAJXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVGAJXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:23:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38305 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263233AbVGAJW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:22:59 -0400
Date: Fri, 1 Jul 2005 11:24:14 +0200
From: Jens Axboe <axboe@suse.de>
To: David Masover <ninja@slaphack.com>
Cc: Chris Wedgwood <cw@f00f.org>, Al Boldi <a1426z@gawab.com>,
       "'Nathan Scott'" <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
Message-ID: <20050701092412.GD2243@suse.de>
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org> <42C4FC14.7070402@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C4FC14.7070402@slaphack.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01 2005, David Masover wrote:
> Chris Wedgwood wrote:
> >On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> >
> >
> >>What I found were 4 things in the dest dir:
> >>1. Missing Dirs,Files. That's OK.
> >>2. Files of size 0. That's acceptable.
> >>3. Corrupted Files. That's unacceptable.
> >>4. Corrupted Files with original fingerprint. That's ABSOLUTELY
> >>unacceptable.
> >
> >
> >disk usually default to caching these days and can lose data as a
> >result, disable that
> 
> Not always possible.  Some disks lie and leave caching on anyway.

And the same (and others) disks will not honor a flush anyways. Moral of
that story - avoid bad hardware.

-- 
Jens Axboe

