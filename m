Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUJYVNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUJYVNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUJYVJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:09:54 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:53778 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262060AbUJYU6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:58:35 -0400
Date: Mon, 25 Oct 2004 22:59:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       ppokorny@penguincomputing.com
Subject: Re: [PATCH] 2.6 lm85.c driver update
Message-Id: <20041025225959.6026626f.khali@linux-fr.org>
In-Reply-To: <20041025203610.GA19053@penguincomputing.com>
References: <20041004200943.GE22290@penguincomputing.com>
	<20041019222920.GJ9521@kroah.com>
	<20041025203610.GA19053@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hm, there are a number of rejects in this patch.  Care to resync up
> > with the next kernel release and resend this?
> 
> Ok, try this:
> 
> signed off by:  Justin Thiessen  <jthiessen@penguincomputing.com>
> 
> patch for kernel 2.6.X lm85 driver follows:
> ----------------------------------------------------
> 
> --- linux-2.6.9/drivers/i2c/chips/lm85.c.orig	2004-10-18 14:53:46.000000000 -0700
> +++ linux-2.6.9/drivers/i2c/chips/lm85.c	2004-10-24 18:16:04.188509824 -0700

Unfortunately this won't be OK either. 2.6.10-rc1 has a lot of i2c
changes, including a number of things your patch attempts to fix (macro
abuse reported by Mark Hoffman). So it won't apply to Greg's tree.

Please provide your patch against 2.6.10-rc1. Sorry that you always seem
to provide your patch against the not-really-last tree ;)

-- 
Jean Delvare
http://khali.linux-fr.org/
