Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSL3KmV>; Mon, 30 Dec 2002 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbSL3KmU>; Mon, 30 Dec 2002 05:42:20 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:27398 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266841AbSL3KmU>; Mon, 30 Dec 2002 05:42:20 -0500
Date: Mon, 30 Dec 2002 10:51:14 +0000
To: Kevin Corry <corry@ecn.purdue.edu>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, dm-devel@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm.c : Check memory allocations
Message-ID: <20021230105114.GB2703@reti>
References: <200212272155.gBRLtWD7013508@shay.ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212272155.gBRLtWD7013508@shay.ecn.purdue.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 04:55:31PM -0500, Kevin Corry wrote:
> Check memory allocations when cloning bio's.

Rejected, clone_bio() cannot fail since it's allocating from a mempool
with __GFP_WAIT set.

- Joe
