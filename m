Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbULTJ3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbULTJ3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbULTJ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:29:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:16292 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261429AbULTJ3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:29:41 -0500
Subject: Re: /sys/block vs. /sys/class/block
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <41C68A6D.6060801@yahoo.com.au>
References: <1103526532.5320.33.camel@gaston>
	 <41C68A6D.6060801@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 10:29:18 +0100
Message-Id: <1103534958.14050.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Seems like that's where it belongs.
> 
> The reason why it is in /sys/block is because it is apparently a "subsystem",
> and using decl_subsys - drivers/block/genhd.c

I'm not convinced ... If you look at how /sys is organized, it really
doesn't make any sense ... block devives are really devices of "class
block", wether we have a block "subsystem" in there is irrelevant imho.

Ben.


