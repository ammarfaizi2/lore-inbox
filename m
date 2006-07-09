Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWGIUYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWGIUYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWGIUYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:24:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161120AbWGIUYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:24:09 -0400
Date: Sun, 9 Jul 2006 13:24:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709132400.a7f6e358.akpm@osdl.org>
In-Reply-To: <200607091928.07179.dominik.karall@gmx.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<200607091928.07179.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 19:28:07 +0200
Dominik Karall <dominik.karall@gmx.net> wrote:

> On Sunday, 9. July 2006 11:11, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> >8-rc1/2.6.18-rc1-mm1/
> 
> There are stil problems with initializing the bt878 chip. I'm not sure 
> if it is the same bug, but I had problems with all -mm versions since 
> 2.6.17-mm1
> Screenshot: 
> http://stud4.tuwien.ac.at/~e0227135/kernel/060709_190546.jpg
> 

Right - this is one of those mysterious crashes deep in sysfs from calling
code which basically hasn't changed.  Mauro and Greg are vacationing or
otherwise offline so not much is likely to happen short-term.

Is 2.6.18-rc1 OK?
