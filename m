Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269555AbTG1NFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbTG1NFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:05:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41912 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269555AbTG1NFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:05:32 -0400
Date: Mon, 28 Jul 2003 15:20:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [RFC][PATCH 2.6.0-test2] get rid of unused request_queue field queue_wait
Message-ID: <20030728132045.GF25356@suse.de>
References: <3F24D8B8.5030107@aros.net> <20030728121844.GE25356@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728121844.GE25356@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28 2003, Jens Axboe wrote:
> On Mon, Jul 28 2003, Lou Langholtz wrote:
> > Are we going to use the queue_wait field of struct request_queue 
> > someday? As of 2.6.0-test2, I don't see any use of it. If it's not 
> > needed anymore, the following patch gets rid of it. Tested this patch by 
> > compiling for i386 and also doing a grep through all .h and .c files to 
> > see if it's used somewhere else (admittedly weak).
> 
> It's a relic from before dynamic request allocation, for now it can
> definitely go.

Eh sorry, still very much jet lagged. It has nothing to do with request
allocation. The point still stands though, it can be removed.

-- 
Jens Axboe

