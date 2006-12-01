Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936496AbWLAOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936496AbWLAOId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936501AbWLAOId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:08:33 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:53174 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S936496AbWLAOIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:08:32 -0500
Date: Fri, 1 Dec 2006 09:08:31 -0500
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd/tg3 issue
Message-ID: <20061201140830.GB2021@washoe.onerussian.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061130150406.3d0b6afd@localhost.localdomain> <E1Gq1kG-0003q5-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Gq1kG-0003q5-00@gondolin.me.apana.org.au>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since this is a 2nd order allocation, it could also be that you have
> memory but it's fragmented. 
Thanks for the info!

> If you aren't using jumbograms you can
> try disabling that.
disabling 2nd order allocation?
and I do use jumbos on that box (it is an NFS server so jumbo frames --
MTU 9000 -- presumable help a bit on CPU utilization)

> Cheers,
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Student  Ph.D. @ CS Dept. NJIT
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07102
WWW:     http://www.linkedin.com/in/yarik        
