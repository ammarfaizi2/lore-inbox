Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVAWJUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVAWJUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVAWJUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:20:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:50852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbVAWJUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:20:01 -0500
Date: Sun, 23 Jan 2005 01:19:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050123011918.295db8e8.akpm@osdl.org>
In-Reply-To: <20050123091154.GC16648@suse.de>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  This is after 2 days of uptime, the box is basically unusable.

hm, no indication where it all went.

Does the machine still page properly?  Can you do a couple of monster
usemems or fillmems to page everything out, then take another look at
meminfo and the sysrq-M output?

