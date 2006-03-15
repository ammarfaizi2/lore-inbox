Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWCODTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWCODTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCODTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:19:31 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:40328 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751965AbWCODTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:19:30 -0500
Date: Tue, 14 Mar 2006 19:16:25 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] hostap_{pci,plx}.c: fix memory leaks
Message-ID: <20060315031625.GE9384@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060313222841.GQ13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313222841.GQ13973@stusta.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 11:28:41PM +0100, Adrian Bunk wrote:
> This patch fixes two memotry leaks spotted by the Coverity checker.

Thanks. I'll make a bit different patch to resolve this and related PCI
"leaks" in one change. I'm going through the Coverity reports for Host
AP driver, so I'll include other fixes in a patch set, too.

-- 
Jouni Malinen                                            PGP id EFC895FA
