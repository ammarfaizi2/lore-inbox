Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTDGB34 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTDGB34 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:29:56 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22284
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263179AbTDGB3z 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:29:55 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030406183234.1e8abd7f.akpm@digeo.com>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
	 <20030406183234.1e8abd7f.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049679689.753.170.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 21:41:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 21:32, Andrew Morton wrote:

> Does it work OK with earlier 2.5 kernels?
> 
> The only change which comes to mind is the below one.  Could you do a
> patch -R of this and retest?

This has been happening since 2.5.60-ish.

It is NPTL-related.  Mr. Day, doing this:

	LD_ASSUME_KERNEL=2.2.5 rpm <...>

should "fix" the problem.

I have not yet tracked down what in 2.5 is broken, but Red Hat's kernel
obviously does not have this flaw.

	Robert Love

