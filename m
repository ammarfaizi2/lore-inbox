Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUJAPMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUJAPMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUJAPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:12:13 -0400
Received: from waste.org ([209.173.204.2]:23179 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261169AbUJAPML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:12:11 -0400
Date: Fri, 1 Oct 2004 10:11:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org
Subject: Re: [patch] make dnotify compile-time configurable
Message-ID: <20041001151124.GQ31237@waste.org>
References: <1096611874.4803.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096611874.4803.18.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 02:24:34AM -0400, Robert Love wrote:
> Attached patch makes dnotify compile-time configurable via
> CONFIG_DNOTIFY.  The patch stands alone from the inotify patch, although
> it really makes most sense in that context.  Maybe the tiny kernel will
> find it useful as well.

Indeed, it's been useful for months. Unfortunately my development
boxes are still mothballed so progress upstream is stalled.

> Disabling CONFIG_DNOTIFY saves a couple hundred bytes off of vmlinux.

Hmm, thought I saved at least 1 or 2k.

-- 
Mathematics is the supreme nostalgia of our time.
