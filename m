Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbSJCWIv>; Thu, 3 Oct 2002 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSJCWIv>; Thu, 3 Oct 2002 18:08:51 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:263
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261211AbSJCWIu>; Thu, 3 Oct 2002 18:08:50 -0400
Subject: Re: export of sys_call_table
From: Robert Love <rml@tech9.net>
To: bidulock@openss7.org
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003153943.E22418@openss7.org>
References: <20021003153943.E22418@openss7.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 18:14:29 -0400
Message-Id: <1033683270.909.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 17:39, Brian F. G. Bidulock wrote:

> I see that RH, in their infinite wisdom, have seen fit to remove
> the export of sys_call_table in 8.0 kernels breaking any loadable
> modules that wish to implement non-implemented system calls such
> as LiS's or iBCS implementation of putmsg/getmsg.

It is not safe.

> What is the kernel.org take on this?

I do not think it matters what our opinion is.  Red Hat is free to do
whatever they wish.  They certainly give enough back to kernel
development that they are able to.  In this case, however, I see good
reason for it - overwriting syscall table entries has a number of sticky
points...

	Robert Love

