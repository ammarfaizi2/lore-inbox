Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVIMBWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVIMBWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 21:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVIMBWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 21:22:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbVIMBWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 21:22:41 -0400
Date: Mon, 12 Sep 2005 18:21:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: lion.vollnhals@web.de, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH fwd -mm] [v2] drivers/base/*: use kzalloc instead of
 kmalloc+memset
Message-Id: <20050912182141.202ff521.akpm@osdl.org>
In-Reply-To: <200509130106.j8D16cZA011840@wscnet.wsc.cz>
References: <200509130151.18867.lion.vollnhals@web.de>
	<200509130106.j8D16cZA011840@wscnet.wsc.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:
>
> > Furthermore this patch fixes actually two bugs in drivers/base/class.c:
> > The memset arguments were occasionally swaped and therefore wrong.

yup.

> 
>  Applicable to 2.6.13-mm3.
>

I'll split this into against-linus and against-greg bits and shall send one
patch to each person, thanks.

