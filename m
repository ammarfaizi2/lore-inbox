Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSKJKtK>; Sun, 10 Nov 2002 05:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264800AbSKJKtK>; Sun, 10 Nov 2002 05:49:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58566 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264798AbSKJKtJ>;
	Sun, 10 Nov 2002 05:49:09 -0500
Date: Sun, 10 Nov 2002 11:55:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Helge Hafting <helge.hafting@broadpark.no>, linux-kernel@vger.kernel.org
Subject: Re: raid-0 BUG in 2.5.46-bk4
Message-ID: <20021110105514.GI31134@suse.de>
References: <3DCC3D41.386DB98C@broadpark.no> <15820.21092.115557.979931@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15820.21092.115557.979931@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09 2002, Neil Brown wrote:
> Jens:  It looks like the biovec arg to  ->merge_bvec_fn is
> un-necessary.  Is that right or am I missing something?

It is, I'm leaving it alone until the ->map + ->submit stuff is done
though.

-- 
Jens Axboe

