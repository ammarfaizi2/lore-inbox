Return-Path: <linux-kernel-owner+w=401wt.eu-S1161305AbXAHPfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbXAHPfF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbXAHPfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:35:05 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:2656 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161305AbXAHPfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:35:03 -0500
Date: Mon, 8 Jan 2007 10:14:45 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       Ulrich Kunitz <kune@deine-taler.de>
Subject: Re: [patch 28/50] softmac: Fixed handling of deassociation from AP
Message-ID: <20070108151424.GB22498@tuxdriver.com>
References: <20070106022753.334962000@sous-sol.org> <20070106023408.591445000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106023408.591445000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 06:28:21PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Ulrich Kunitz <kune@deine-taler.de>
> 
> In 2.6.19 a deauthentication from the AP doesn't start a
> reassociation by the softmac code. It appears that
> mac->associnfo.associating must be set and the
> ieee80211softmac_assoc_work function must be scheduled. This patch
> fixes that.
> 
> Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>

ACK

-- 
John W. Linville
linville@tuxdriver.com
