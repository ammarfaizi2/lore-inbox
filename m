Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUKUXyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUKUXyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUKUXya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:54:30 -0500
Received: from dp.samba.org ([66.70.73.150]:52406 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261852AbUKUXy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:54:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16801.10881.894206.174581@samba.org>
Date: Mon, 22 Nov 2004 10:53:37 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119162651.2d62a6a8.akpm@osdl.org>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<20041119162651.2d62a6a8.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

 > Is it reproducible with your tricked-up dbench?
 > 
 > If so, please send me a machine description and the relevant command line
 > and I'll do a bsearch.

The new dbench is finished (see my reply to Nathan for details).

I've done some initial runs comparing 2.6.10-rc2 and 2.6.10-rc2-mm2
and I am not seeing the performance gain with mm2 that I reported
earlier. I don't yet know if this is because I screwed up previously,
or there is some other factor that I haven't taken account of.

I'm now doing a larger set of runs comparing the two kernels with a
range of filesystems and much longer run times, plus more repeats per
run. I'm also using a script that reformats the filesystem before each
run in case that was a factor (as it was for reiser4). I'll get you
the results later today.

Cheers, Tridge
