Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUCEJUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCEJUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:20:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39570 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262277AbUCEJUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:20:39 -0500
Date: Fri, 5 Mar 2004 10:20:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Kyle Wong <kylewong@southa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: questions about io scheduler
Message-ID: <20040305092029.GB10923@suse.de>
References: <088201c40293$5b27ce80$9c02a8c0@southa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088201c40293$5b27ce80$9c02a8c0@southa.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05 2004, Kyle Wong wrote:
> 1. Is  anticipatory io scheduler + echo 0 >
> /sys/block/hd*/queue/iosched/antic_expire = deadline scheduler?

It isn't 100% the same, but very very close.

> 2. Does io scheduler works with md RAID? Correct me if I'm wrong,
> io-schedular <-->  md driver <--> harddisks.

No, it's md -> io scheduler -> hard drive.

-- 
Jens Axboe

