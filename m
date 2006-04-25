Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWDYN3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWDYN3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWDYN3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:29:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932219AbWDYN3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:29:36 -0400
Date: Tue, 25 Apr 2006 15:06:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: rmk+lkml@arm.linux.org.uk
Subject: Re: fs/splice.c:286: warning: comparison of distinct pointer types lacks a cast
Message-ID: <20060425130629.GC4102@suse.de>
References: <20060422194131.GA4133@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422194131.GA4133@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22 2006, Russell King wrote:
> fs/splice.c: In function '__generic_file_splice_read':
> fs/splice.c:286: warning: comparison of distinct pointer types lacks a cast
> 
> seems to be a warning from min(), so is potentially a bug.

(you should cc someone, btw)

It's fixed in the git repo already, it'll go out soonish.

-- 
Jens Axboe

