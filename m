Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSLLMAq>; Thu, 12 Dec 2002 07:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSLLMAq>; Thu, 12 Dec 2002 07:00:46 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:31500 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263794AbSLLMAq>; Thu, 12 Dec 2002 07:00:46 -0500
Date: Thu, 12 Dec 2002 12:08:36 +0000
To: Wil Reichert <wilreichert@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
Message-ID: <20021212120836.GA5717@reti>
References: <1039572597.459.82.camel@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039572597.459.82.camel@darwin>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 09:17:45PM -0500, Wil Reichert wrote:
> Hi,
> 
> I'm getting a "bio too big" error with 2.5.50.  I've got a 330G lvm2
> partition formatted with ext3 using the -T largefile4 parameter. 
> Everything seems ok at first, but any sort of access will die very
> unhappily with said error messsage after about 10 seconds of operation
> or so.  The only google search results are the patch submission.  Eeek.

Could you try the patchset below please ?  (you may need to knock out
patch 5 until we get to the bottom of that particular bug).

http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/2.5.51-dm-2.tar.bz2

- Joe
