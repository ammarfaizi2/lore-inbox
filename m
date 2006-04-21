Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWDUT2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWDUT2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWDUT2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:28:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932315AbWDUT2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:28:07 -0400
Date: Fri, 21 Apr 2006 12:26:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dwalker@mvista.com, tilman@imap.cc, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-Id: <20060421122652.72655580.akpm@osdl.org>
In-Reply-To: <1145642459.24962.12.camel@localhost.localdomain>
References: <63XWg-1IL-5@gated-at.bofh.it>
	<63YfP-26I-11@gated-at.bofh.it>
	<63ZEY-45n-27@gated-at.bofh.it>
	<4448F97D.5000205@imap.cc>
	<1145635403.20843.21.camel@localhost.localdomain>
	<1145642459.24962.12.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Total number of NULL frees:      16129
>  Total number of non NULL frees:  18119
> ....
>  [     6491]  c01aafc4 - start_this_handle+0x234/0x4b0
>  [     8404]  c01aba66 - do_get_write_access+0x2e6/0x5a0

eh.  I'll fix those up.
