Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932830AbWCRBRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWCRBRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWCRBR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:17:29 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:63248 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932827AbWCRBR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:17:27 -0500
Date: Fri, 17 Mar 2006 20:14:14 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee80211_wx.c: remove dead code
Message-ID: <20060318011409.GH25249@tuxdriver.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060315164015.GZ13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315164015.GZ13973@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 05:40:15PM +0100, Adrian Bunk wrote:
> Since sec->key_sizes[] is an u8, len can't be < 0.
> 
> Spotted by the Coverity checker.

Merged to upstream branch of wireless-2.6...thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
