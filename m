Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTG1MD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTG1MD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:03:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61863 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262439AbTG1MD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:03:29 -0400
Date: Mon, 28 Jul 2003 14:18:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [RFC][PATCH 2.6.0-test2] get rid of unused request_queue field queue_wait
Message-ID: <20030728121844.GE25356@suse.de>
References: <3F24D8B8.5030107@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F24D8B8.5030107@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28 2003, Lou Langholtz wrote:
> Are we going to use the queue_wait field of struct request_queue 
> someday? As of 2.6.0-test2, I don't see any use of it. If it's not 
> needed anymore, the following patch gets rid of it. Tested this patch by 
> compiling for i386 and also doing a grep through all .h and .c files to 
> see if it's used somewhere else (admittedly weak).

It's a relic from before dynamic request allocation, for now it can
definitely go.

-- 
Jens Axboe

