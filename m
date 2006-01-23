Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWAWTBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWAWTBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWAWTBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:01:17 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:60858 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S964898AbWAWTBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:01:16 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [softmac-dev] [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt
Date: Mon, 23 Jan 2006 20:00:11 +0100
User-Agent: KMail/1.8
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "John W. Linville" <linville@tuxdriver.com>, jbenc@suse.cz,
       netdev@vger.kernel.org, softmac-dev@sipsolutions.net,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com> <200601221404.52757.vda@ilport.com.ua> <1138026752.3957.98.camel@localhost>
In-Reply-To: <1138026752.3957.98.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601232000.12400.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag 23 Januar 2006 15:32 schrieb Johannes Berg:

> Shouldn't you BSS-filter management packets too?

no, management packets are used to populate f.e. scanning results.

Stefan
