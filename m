Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUFAX3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUFAX3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUFAX3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:29:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:20187 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265285AbUFAX3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:29:51 -0400
Date: Tue, 1 Jun 2004 16:32:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Clements <paul.clements@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: fix device names
Message-Id: <20040601163234.029af1b6.akpm@osdl.org>
In-Reply-To: <40BC8C49.4020602@steeleye.com>
References: <4034FDD0.33BC57AF@SteelEye.com>
	<40BC8C49.4020602@steeleye.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements <paul.clements@steeleye.com> wrote:
>
> It seems more appropriate to call the devices "nbX" rather than "nbdX",
> since that's what the device nodes are actually named.

This affects /proc/partitions, /proc/diskstats, and probably other things. 
I think it's too late to change it.
