Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWHTSgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHTSgG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHTSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:36:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:9866 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751133AbWHTSgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:36:05 -0400
X-Authenticated: #704063
Date: Sun, 20 Aug 2006 20:36:00 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       drzeus-sdhci@drzeus.cx
Subject: Re: [Patch] Signedness issue in drivers/net/phy/phy_device.c
Message-ID: <20060820183600.GA3431@alice>
References: <1156008815.18192.3.camel@alice> <44E7E112.3010500@student.ltu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E7E112.3010500@student.ltu.se>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.18-rc4 (i686)
X-Uptime: 20:35:20 up  9:08,  4 users,  load average: 0.00, 0.14, 0.29
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard Knutsson (ricknu-0@student.ltu.se) wrote:
> Eric Sesterhenn wrote:
hi,

> Would it not be preferable to use a 's32' instead of an 'int'? After 
> all, it seem 'val' needs to be 32 bits.

not sure, but wouldnt this collide with platforms where an int is 64
Bits?

Eric

