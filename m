Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbULBO3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbULBO3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbULBO3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:29:08 -0500
Received: from denise.shiny.it ([194.20.232.1]:14470 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261632AbULBO3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:29:03 -0500
Date: Thu, 2 Dec 2004 15:28:44 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Time sliced CFQ io scheduler
In-Reply-To: <20041202130457.GC10458@suse.de>
Message-ID: <Pine.LNX.4.58.0412021517070.3471@denise.shiny.it>
References: <20041202130457.GC10458@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Dec 2004, Jens Axboe wrote:

> Case 4: write_files, random, bs=4k

Just a thought... in this test the results don't look right. Why
aggregate bandwidth with 8 clients is higher than with 4 and 2 clients ?
In the cfq test with 8 clients aggregate bw is also higher than with
a single client.


--
Giuliano.
