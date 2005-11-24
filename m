Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVKXQHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVKXQHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKXQHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:07:35 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:56255 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1751266AbVKXQHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:07:35 -0500
Date: Thu, 24 Nov 2005 18:07:25 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: + shut-up-warnings-in-ipc-shmc.patch added to -mm tree
In-reply-to: <20051124160012.GQ31287@waste.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Hugh Dickins <hugh@veritas.com>, Russell King <rmk@arm.linux.org.uk>,
       akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Message-id: <20051124160725.GA11863@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200511230413.jAN4DboR013036@shell0.pdx.osdl.net>
 <Pine.LNX.4.61.0511241235450.3504@goblin.wat.veritas.com>
 <20051124160012.GQ31287@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:00:12AM -0800, Matt Mackall wrote:
> If we're going to start converting such things, I'd almost rather do
> something like:
> 
> kernel.h:
> static inline void empty_void(void) {}
> static inline void empty_int(void) { return 0; }
                ^^^^

surely if it's returning an int it should be declared as
static inline int empty_int(void) { return 0; }
?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

