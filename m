Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265453AbTGHGet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbTGHGet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:34:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265453AbTGHGes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:34:48 -0400
Date: Mon, 7 Jul 2003 23:49:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: JFFS2: many compile warnings with gcc 2.95 + kernel 2.5
Message-Id: <20030707234910.3d9a9c60.akpm@osdl.org>
In-Reply-To: <1057646526.28965.4.camel@imladris.demon.co.uk>
References: <20030708001937.GA6848@fs.tum.de>
	<20030707180023.0877085e.akpm@osdl.org>
	<1057646526.28965.4.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2003-07-08 at 02:00, Andrew Morton wrote:
> > Switching to %Z will fix that up.
> 
> Please don't. 
> 
> If you really can't ignore the cosmetic warnings, then either use a
> C99-compliant compiler or remove the printf attribute from printk's
> declaration in linux/kernel.h.
> 

We work around gcc problems all the time.  It is called "being practical".

