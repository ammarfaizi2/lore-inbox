Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUFVJPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUFVJPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUFVJPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:15:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:63919 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbUFVJPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:15:48 -0400
Date: Tue, 22 Jun 2004 02:14:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-Id: <20040622021441.4f6aa13c.akpm@osdl.org>
In-Reply-To: <20040622091219.GA32146@infradead.org>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
	<20040622085901.GA31971@infradead.org>
	<20040622020417.0ec87564.akpm@osdl.org>
	<20040622091219.GA32146@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 22, 2004 at 02:04:17AM -0700, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Jun 22, 2004 at 01:53:11AM -0700, Andrew Morton wrote:
> > > > Also there should be a document or a manpage or something which describes,
> > > > in detail:
> > > > 
> > > > - the user/kernel API  (separate document, probably)
> > > 
> > > It also needs moving back to /proc/<pid>/ files from the syscall API.
> > 
> > What does this mean?
> 
> Early version of perfctr used files in /proc/<pid>/ for controlling perfctr
> instead of the syscalls, and indeed that's a much better fit for most of them.
> Let's ressurect that code instead of doing the syscall approach.

This appears to have come out of the blue.  Please explain why you think
this change is needed.
