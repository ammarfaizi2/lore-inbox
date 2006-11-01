Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992599AbWKAPRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992599AbWKAPRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992598AbWKAPRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:17:41 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:3601 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S2992599AbWKAPRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:17:40 -0500
Date: Wed, 1 Nov 2006 10:13:53 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 25/61] bcm43xx: fix watchdog timeouts.
Message-ID: <20061101151347.GD21668@tuxdriver.com>
References: <20061101053340.305569000@sous-sol.org> <20061101053933.470581000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101053933.470581000@sous-sol.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:34:05PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Michael Buesch <mb@bu3sch.de>
> 
> This fixes a netdev watchdog timeout problem.
> The problem is caused by a needed netif_tx_disable
> in the hardware calibration code and can be shown by the
> following timegraph.

ACK
-- 
John W. Linville
linville@tuxdriver.com
