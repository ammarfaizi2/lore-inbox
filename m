Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTEUHzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTEUHmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:42:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261561AbTEUHln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:43 -0400
Date: Wed, 21 May 2003 07:31:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex patches, futex-2.5.69-A2
Message-ID: <20030521073112.A1316@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>, Ingo Molnar <mingo@elte.hu>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	KML <linux-kernel@vger.kernel.org>
References: <20030520150826.A18282@infradead.org> <Pine.LNX.4.44.0305201748020.14480-100000@localhost.localdomain> <20030520205512.A5889@infradead.org> <1053493564.9142.1504.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053493564.9142.1504.camel@workshop.saharact.lan>; from azarah@gentoo.org on Wed, May 21, 2003 at 07:06:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 07:06:57AM +0200, Martin Schlemmer wrote:
> On Tue, 2003-05-20 at 21:55, Christoph Hellwig wrote:
> > On Tue, May 20, 2003 at 06:02:07PM +0200, Ingo Molnar wrote:
> > > you havent ever used Ulrich's nptl-enabled glibc, have you? It will boot
> > > on any 2.4.1+ kernel, with and without nptl/tls support. It switches the
> > > threading implementation depending on the kernel features it detects.
> > 
> > I have built a nptl-enabled glibc and no, it's doesn't work on 2.4 at all.
> > 
> 
> It is because you only compiled it with nptl support.

I know.  I didn't ever claim you can install multiple glibc version.

> In recent (nptl enabled) Redhat glibc's glibc is build two times.

For x86 it's even built three times..

