Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992498AbWJTFtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992498AbWJTFtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992506AbWJTFtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:49:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992498AbWJTFtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:49:51 -0400
Date: Thu, 19 Oct 2006 22:49:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor fixes to generic do_div
Message-Id: <20061019224949.37a12fda.akpm@osdl.org>
In-Reply-To: <20061020053638.GS2602@parisc-linux.org>
References: <20061020033359.GR2602@parisc-linux.org>
	<20061019215954.1be82a57.akpm@osdl.org>
	<20061020053638.GS2602@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 23:36:38 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Thu, Oct 19, 2006 at 09:59:54PM -0700, Andrew Morton wrote:
> > Can we use typecheck(), from include/linux/kernel.h?
> 
> I don't know.
> 
> It's copied and pasted from down below, so possibly this was
> intentionally not used.  or possibly the author didn't know about
> typecheck().

or typecheck() was added afterwards.

One could create a typecheck.h.  Or a handy-macros.h whose mandate is
"macros which don't depend on any other headers".

Or just include kernel.h in div64.h.
