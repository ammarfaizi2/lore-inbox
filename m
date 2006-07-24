Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWGXI3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWGXI3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWGXI3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:29:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:46269 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750712AbWGXI3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:29:19 -0400
X-Authenticated: #428038
Date: Mon, 24 Jul 2006 10:29:16 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Paa Paa <paapaa125@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CFQ will be the new default IO scheduler - why?
Message-ID: <20060724082916.GB24299@merlin.emma.line.org>
Mail-Followup-To: Paa Paa <paapaa125@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY20-F21F536F116290D1C8F5FF4F9640@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F21F536F116290D1C8F5FF4F9640@phx.gbl>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006, Paa Paa wrote:

> The default IO scheduler in 2.6.18 will be CFQ (Complete Fair Queuing) 
> instead of AS (Anticipatory Scheduler) as described here: 
> http://wiki.kernelnewbies.org/Linux_2_6_18. I tried to find (here, at lkml) 
> the discussion about this change with no luck.

That wiki document nicely shows the advantage of the scheduler, namely
that you have "ionice", which isn't possible for AS or Deadline
Schedulers - this allows the operating system to run processes like
updatedb with "nice I/O", meaning these hold when you're doing other
I/O.

-- 
Matthias Andree
