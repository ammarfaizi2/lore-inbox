Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbUCTWGD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbUCTWGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:06:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:26590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263553AbUCTWGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:06:01 -0500
Date: Sat, 20 Mar 2004 14:06:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa3
Message-Id: <20040320140602.7bd6bb73.akpm@osdl.org>
In-Reply-To: <20040320210306.GA11680@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 	Writeback changes from 2.6.5-rc1-mm2 to reduce the difference
>  	with other trees, and to avoid having to maintain significantly
>  	different versions of anon_vma.

yup.  I'd hope to get these merged up post-2.6.5.  There's possibly one
little kupdate problem which I need to look into today.

Daniel is still showing a once-per-three-hours data exposure leak with
O_DIRECT-versus-buffered on 8-way on ext3 (not on ext2) which I need to
think about a bit.

