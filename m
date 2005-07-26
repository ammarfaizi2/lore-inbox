Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVGZTPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVGZTPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVGZTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:13:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262017AbVGZTLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:11:32 -0400
Date: Tue, 26 Jul 2005 12:10:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: kaneshige.kenji@jp.fujitsu.com, ambx1@neo.rr.com, greg@kroah.org,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-Id: <20050726121019.0248801c.akpm@osdl.org>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03FCF24C@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03FCF24C@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> I started on my OLS homework from Andrew ... and began looking
> into what is going on here.
> 

Thanks ;) I guess we'll end up with a better kernel, even though you appear
to be an innocent victim here.

> 
> Andrew: How did you get the squitty font on ia64?  The stack trace
> from the oops flies off the top of the screen.  I've tried a few
> "vga=0x0f07" type options, but I keep getting a big font.

I put

SYSFONT="iso08.08"

in /etc/sysconfig/i18n
