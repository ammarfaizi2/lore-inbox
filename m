Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbUL0Sjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbUL0Sjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUL0Sjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 13:39:53 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:16588 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S261944AbUL0Sjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 13:39:51 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: cache and buffer usage with kernel 2.6.10
Date: Mon, 27 Dec 2004 19:08:29 +0100
User-Agent: KMail/1.6.2
References: <BAY15-F419E77AD01BC2D2F7A1149B2990@phx.gbl>
In-Reply-To: <BAY15-F419E77AD01BC2D2F7A1149B2990@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412271908.31269.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 27 December 2004 17:33, M Benz wrote:
> Is there any change with memory management btw the two kernels? Also, what 
> is the different btw "cache" and "buffer"? Why don't kernel 2.6.10 use all 
> the memory but leave around 200MB free?

These metrics have been useless from the very beginning and are
not very descriptive. If you like to get some meaning in
your statistice, use vmstat. This is more costly, but actually shows
something about the performance of your system.

Maybe we could concentrate on exporting these metrics instead buffer/cache
and provide dummy metrics for them. At least "buffer" can be made to
sth. like "shared" does now.

Regards

Ingo Oeser


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB0E+dU56oYWuOrkARAssXAKDEPxGEE+r162ZGRcYTarl7qofvGgCfX2Yt
6IdeNnYV+lZvbgT0trg9xtc=
=+6ii
-----END PGP SIGNATURE-----
