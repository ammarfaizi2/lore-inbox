Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSKJCOj>; Sat, 9 Nov 2002 21:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSKJCOj>; Sat, 9 Nov 2002 21:14:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14408 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263137AbSKJCOi>; Sat, 9 Nov 2002 21:14:38 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
	<m1u1iqcpjg.fsf@frodo.biederman.org>
	<1036894080.22151.3.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 19:18:39 -0700
In-Reply-To: <1036894080.22151.3.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1fzuacglc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sat, 2002-11-09 at 23:05, Eric W. Biederman wrote:
> > There are two cases I am seeing users wanting.
> > 1) Load a new kernel on panic.
> 
> Load a new *something* on panic. That something might be a new kernel
> but it might also be a kernel dump system like LKCD or a debugger front
> end for something like kdb, or a network dump module, or ...

And if it isn't a kernel why not load it as a module?  The code
has to come preloaded anyway.

Eric
