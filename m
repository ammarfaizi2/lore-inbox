Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268023AbUHPXOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268023AbUHPXOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUHPXNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:13:22 -0400
Received: from waste.org ([209.173.204.2]:45780 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268026AbUHPXMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:12:46 -0400
Date: Mon, 16 Aug 2004 18:12:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] make netpoll_set_trap EXPORT_SYMBOL_GPL
Message-ID: <20040816231235.GH31237@waste.org>
References: <16673.14160.843507.617388@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16673.14160.843507.617388@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 06:38:08PM -0400, Jeff Moyer wrote:
> Hi, Matt,
> 
> I believe that we should export the netpoll_set_trap routine as GPL only,
> since vendors could conceivably use it to by-pass the networking stack
> completely.  Jeff, correct me if I'm wrong, but I think this is what you
> intended when you commented on it many months ago (sorry, can't find the
> thread).

Hmmm, thought I closed that hole the first time around. How do you
envision bypassing the stack in the current approach?

-- 
Mathematics is the supreme nostalgia of our time.
