Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJRQnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJRQnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:43:42 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3219 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261699AbTJRQnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:43:41 -0400
Date: Sat, 18 Oct 2003 18:43:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Message-ID: <20031018164337.GB11066@wohnheim.fh-wedel.de>
References: <200310180018.21818.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310180018.21818.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 October 2003 00:18:21 -0500, Rob Landley wrote:
> 
> I just rewrote bunzip2 for busybox in about 500 lines of C (and a good chunk 
> of that's comments), which comiles to a bit under 7k.

5140 on my machine, compared to 9436 for the stock decompress.o.  Nice.

Does it survive the bzip2 testcases?

> P.S.  If you're curious about the micro-bunzip code, it's in busybox CVS:
> http://www.busybox.net/cgi-bin/cvsweb/busybox/archival/libunarchive/decompress_bunzip2.c

Not pretty with 80 columns, but it looks good at first glance.  And
surely more fun to work on than the zlib-inspired code from Julian.

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
