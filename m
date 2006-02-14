Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWBNGME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWBNGME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWBNGMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:12:03 -0500
Received: from fmr18.intel.com ([134.134.136.17]:35222 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030482AbWBNGMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:12:01 -0500
Subject: Re: 2.6.16-rc2-git8: ieee80211 does not compile
From: Zhu Yi <yi.zhu@intel.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060212104920.GU2690@charite.de>
References: <20060210123817.GQ6668@charite.de>
	 <20060212104920.GU2690@charite.de>
Content-Type: text/plain
Organization: Intel Corp.
Date: Tue, 14 Feb 2006 14:06:29 +0800
Message-Id: <1139897189.8403.71.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 11:49 +0100, Ralf Hildebrandt wrote:
>   CC [M]  net/ieee80211/ieee80211_module.o
>   CC [M]  net/ieee80211/ieee80211_tx.o
> net/ieee80211/ieee80211_tx.c: In function ieee80211_xmit':
> net/ieee80211/ieee80211_tx.c:473: error: too few arguments to function

What's your build_iv() prototype (in ieee80211_crypt.h) looks like? You
might be using some late ieee80211 updates which has not been merged to
mainline yet.

Thanks,
-yi

