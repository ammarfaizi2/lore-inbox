Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWDNMgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWDNMgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 08:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWDNMgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 08:36:47 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:59911 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932415AbWDNMgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 08:36:47 -0400
Date: Fri, 14 Apr 2006 14:36:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] DEBUG_KERNEL menu cleanups
Message-ID: <20060414123631.GA14263@mars.ravnborg.org>
References: <20060414111853.GG4162@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060414111853.GG4162@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 01:18:53PM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - move DEBUG_FS above the DEBUG_KERNEL options (it did break the menu)
> - let the following options depend on DEBUG_KERNEL:
>   - PRINTK_TIME
>   - DEBUG_SHIRQ
>   - RT_MUTEX_TESTER
>   - UNWIND_INFO

A simpler solution would be to wrap everything inside
if DEBUG_KERNEL
...
...
...
endif

	Sam
