Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319077AbSHSWhB>; Mon, 19 Aug 2002 18:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319078AbSHSWhB>; Mon, 19 Aug 2002 18:37:01 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:9994
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319077AbSHSWhA>; Mon, 19 Aug 2002 18:37:00 -0400
Subject: Re: MAX_PID changes in 2.5.31
From: Robert Love <rml@tech9.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
References: <200208192231.g7JMVQI28575@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain> 
	<200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 18:41:01 -0400
Message-Id: <1029796863.942.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 18:36, Richard Gooch wrote:

> In other words, "yes, unless you happen not to use SysV IPC semaphores
> or message queues in any of your binaries on your system". So you want
> to break binary compatibility. Please don't. I don't want to downgrade
> to glibc.

So are you saying we can never deprecate interfaces, just so you can
continue using libc5?

Seems saner to keep libc5 in sync with the kernel than vice versa..

	Robert Love

