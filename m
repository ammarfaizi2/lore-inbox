Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVLECOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVLECOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 21:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVLECOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 21:14:33 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:34795 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751344AbVLECOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 21:14:32 -0500
Date: Sun, 4 Dec 2005 18:14:09 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: -mm patch] drivers/net/wireless/hostap/hostap_main.c shouldn't #include C files
Message-ID: <20051205021409.GB8953@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20051203122309.GD31395@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203122309.GD31395@stusta.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 01:23:09PM +0100, Adrian Bunk wrote:
> This patch contains an attempt to properly build hostap.o without 
> #incude'ing C files.

Looks good. However, I did not test this now since this did not apply to
netdev-2.6 (it does not have hostap_main.c). Did the hostap.c to
hostap_main.c rename go only to -mm? I would prefer to do this kind of
changes in a single place and I thought netdev-2.6 would be that. I'm
not following -mm tree at all and it would be easier to go through
patches if they are against netdev-2.6 upstream branch.

-- 
Jouni Malinen                                            PGP id EFC895FA
