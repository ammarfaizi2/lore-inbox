Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272438AbTGZIBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272439AbTGZIBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:01:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:20357 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272438AbTGZIBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:01:41 -0400
Date: Sat, 26 Jul 2003 01:17:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: hch@infradead.org, willy@w.ods.org, hch@lst.de, uclinux-dev@uclinux.org,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, axboe@suse.de
Subject: Re: [PATCH] Make I/O schedulers optional (Was: Re: Kernel 2.6 size
 increase)
Message-Id: <20030726011708.6aa29641.akpm@osdl.org>
In-Reply-To: <200307260155.15099.bernie@develer.com>
References: <200307232046.46990.bernie@develer.com>
	<200307242227.16439.bernie@develer.com>
	<20030725164649.A6557@infradead.org>
	<200307260155.15099.bernie@develer.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
> > Removing the I/O schedulers is pretty trivial, please come up with a
>  > patch to make both of them optional and maybe add a trivial noop one.
> 
>   Here it is, attached below. I've tested it on both i386 and m68knommu.

Is nice, but I wonder if it should be appearing under the 

	General Setup  ->  Remove kernel features

menu?  ie: CONFIG_EMBEDDED.

