Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTGOGPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGOGPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:15:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37771 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263407AbTGOGPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:15:12 -0400
Date: Mon, 14 Jul 2003 23:30:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: george@mvista.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org
Subject: Re: do_div64 generic
Message-Id: <20030714233008.1b5a4d84.akpm@osdl.org>
In-Reply-To: <200307150823.01602.bernie@develer.com>
References: <3F1360F4.2040602@mvista.com>
	<200307150717.54981.bernie@develer.com>
	<20030714223805.4e5bee3f.akpm@osdl.org>
	<200307150823.01602.bernie@develer.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
> Is it worth posting a big patch to replace all remaining
>  occurrences of 'extern inline' all over the kernel?

Not really.  It's a 400k patch.  I have a script which does it.  For those
rare occasions when one wants to build the kernel with -fnoinline.

