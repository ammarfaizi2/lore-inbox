Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTJMMIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTJMMIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:08:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:46278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbTJMMIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:08:42 -0400
Date: Mon, 13 Oct 2003 05:11:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
Message-Id: <20031013051149.29da705a.akpm@osdl.org>
In-Reply-To: <1066046102.14783.11.camel@hades.cambridge.redhat.com>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
	<20031013040219.6ad71a57.akpm@osdl.org>
	<1066044079.24015.442.camel@hades.cambridge.redhat.com>
	<20031013044042.23ab7f69.akpm@osdl.org>
	<1066046102.14783.11.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> > How does userspace identify the JFFS2 process to which to send the
> > signal?
> 
> 	daemonize("jffs2_gcd_mtd%d", c->mtd->index);

And then what?  Parse the output of ps(1)?  Use pidof(8)?

> Bitching accomplished; now can we fix the bug?

Insufficient contrition detected :)

Why cannot a procfs or sysfs control be used?

