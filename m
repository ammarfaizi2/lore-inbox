Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVASQBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVASQBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVASQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:01:14 -0500
Received: from ponzo.noc.sonic.net ([64.142.18.11]:35760 "HELO ponzo.sonic.net")
	by vger.kernel.org with SMTP id S261760AbVASQBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:01:11 -0500
Date: Wed, 19 Jan 2005 08:01:10 -0800
From: Scott Doty <scott@sonic.net>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Thanks for neighbor.c patch (was Re: linux-2.4.29 released
Message-ID: <20050119160110.GC24458@sonic.net>
References: <200501191438.j0JEcU56020913@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501191438.j0JEcU56020913@hera.kernel.org>
User-Agent: Mutt/1.4.1i
X-PGP-Key: http://sonic.net/~scott/gpgkey.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 06:38:30AM -0800, Marcelo Tosatti wrote:
> Summary of changes from v2.4.29-rc2 to v2.4.29-rc3
> ============================================
> 
> <raivis:mt.lv>:
>   o [NEIGH]: Calculate hash_val after possible table growth, not before
> 
> <scott:sonic.net>:
>   o Fix net neighbour hash bug

I want to thank the Linux folks for adding this patch.  In a nutshell:
works great!

We ran -rc2 with the patch on our test server overnight w/stress testing,
then 3 days on a production web server, and finally we deployed the
patched -rc2 on all public-accessable servers.  The "incomplete arp problem"
never showed up.

(Now that 2.4.29 is out, we're going to do an upgrade across the board...)

Thanks again, you guys rock!

 -Scott
