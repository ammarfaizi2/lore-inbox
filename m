Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWJQUXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWJQUXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWJQUXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:23:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751266AbWJQUXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:23:01 -0400
Date: Tue, 17 Oct 2006 13:22:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061017132245.12499c1d.akpm@osdl.org>
In-Reply-To: <4535310C.40708@goop.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<4535310C.40708@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 12:37:48 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > -generic-implementatation-of-bug.patch
> > -generic-implementatation-of-bug-fix.patch
> > +generic-bug-implementation.patch
> >  generic-bug-for-i386.patch
> >  generic-bug-for-x86-64.patch
> >  uml-add-generic-bug-support.patch
> >  use-generic-bug-for-ppc.patch
> >  bug-test-1.patch
> >
> >  Updated generic-BUG-handling patches
> >   
> I thought the powerpc patch had been given a clean bill of health?  Or 
> was there still a problem with it?

No, last time I tested it the machine still froze after "returning from
prom_init".  ie: before it had done any WARNs or BUGs.  It's rather
mysterious.

