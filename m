Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbUJZDUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUJZDUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUJZCwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:52:43 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:22929 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262121AbUJZCjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:39:05 -0400
Date: Mon, 25 Oct 2004 19:38:58 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [swsusp] print error message when swapping is disabled (fwd)
Message-ID: <20041026023858.GA7467@taniwha.stupidest.org>
References: <Pine.LNX.4.44.0410260949340.18363-100000@mazda.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410260949340.18363-100000@mazda.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if ((error = swsusp_swap_check())) {
> +		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
> +				"swapon -a!\n");

maybe it's just me, but i would really prefer to have the occasional
long(er) line that splitting strings like that
