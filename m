Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUAVKaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUAVKaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:30:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57272 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266217AbUAVKaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:30:17 -0500
Date: Thu, 22 Jan 2004 11:30:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Careless bio->_bio change in rq_for_each_bio().
Message-ID: <20040122103007.GO2734@suse.de>
References: <20040122071637.735A32C100@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122071637.735A32C100@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22 2004, Rusty Russell wrote:
> Looks like an obvious typo.  Works fine if "bio" is the name of the
> iterator.

Rusty,

This was already posted a week or two ago, and has been in Linus' tree
since yesterday (or the day before).

-- 
Jens Axboe

