Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755996AbWKSELo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbWKSELo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 23:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbWKSELo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 23:11:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64208 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1755987AbWKSELn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 23:11:43 -0500
Date: Sat, 18 Nov 2006 20:11:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org, mb@bu3sch.de,
       greg@kroah.com, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 07/30] bcm43xx: Drain TX status before starting IRQs
Message-ID: <20061119041127.GU1397@sequoia.sous-sol.org>
References: <20061116024332.124753000@sous-sol.org> <20061116024511.458086000@sous-sol.org> <455F59BB.6060204@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455F59BB.6060204@lwfinger.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Larry Finger (Larry.Finger@lwfinger.net) wrote:
> The regression turns out to be a locking problem involving bcm43xx, 
> wpa_supplicant, and NetworkManager. The exact cause is unknown; however, 
> this patch is clearly not the problem. Please reinstate it for inclusion in 
> -stable.

Thanks for the follow-up, Larry.  It's queued for next -stable.

thanks,
-chris
