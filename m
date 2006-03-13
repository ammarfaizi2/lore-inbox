Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751750AbWCMB0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWCMB0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 20:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCMB0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 20:26:54 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:18050 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751603AbWCMB0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 20:26:53 -0500
Date: Sun, 12 Mar 2006 17:23:41 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] hostap_ap.c:hostap_add_sta(): inconsequent NULL checking
Message-ID: <20060313012341.GV9383@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060310191026.GS21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310191026.GS21864@stusta.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 08:10:26PM +0100, Adrian Bunk wrote:
> The Coverity checker spotted this inconsequent NULL checking 
> (unconditionally dereferencing directly after checking for NULL
> isn't a good idea).

Thanks! Added to my queue for wireless-2.6.

-- 
Jouni Malinen                                            PGP id EFC895FA
