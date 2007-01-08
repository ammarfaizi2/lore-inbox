Return-Path: <linux-kernel-owner+w=401wt.eu-S1161312AbXAHPfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbXAHPfl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbXAHPfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:35:41 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:2660 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161312AbXAHPfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:35:19 -0500
Date: Mon, 8 Jan 2007 10:24:02 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Michael Buesch <mb@bu3sch.de>,
       Johannes Berg <johannes@sipsolutions.net>, dsd@gentoo.org,
       Ulrich Kunitz <kune@deine-taler.de>
Subject: Re: [patch 04/50] ieee80211softmac: Fix mutex_lock at exit of ieee80211_softmac_get_genie
Message-ID: <20070108152356.GD22498@tuxdriver.com>
References: <20070106022753.334962000@sous-sol.org> <20070106022931.148239000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106022931.148239000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 06:27:57PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Ulrich Kunitz <kune@deine-taler.de>
> 
> ieee80211softmac_wx_get_genie locks the associnfo mutex at
> function exit. This patch fixes it. The patch is against Linus'
> tree (commit af1713e0).
> 
> Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>

ACK

-- 
John W. Linville
linville@tuxdriver.com
