Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSKJOBc>; Sun, 10 Nov 2002 09:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264873AbSKJOBc>; Sun, 10 Nov 2002 09:01:32 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:19872 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264872AbSKJOBb>; Sun, 10 Nov 2002 09:01:31 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
In-Reply-To: <m1fzuacglc.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
	<m1u1iqcpjg.fsf@frodo.biederman.org>
	<1036894080.22151.3.camel@irongate.swansea.linux.org.uk> 
	<m1fzuacglc.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 14:31:57 +0000
Message-Id: <1036938717.1009.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 02:18, Eric W. Biederman wrote:
> > Load a new *something* on panic. That something might be a new kernel
> > but it might also be a kernel dump system like LKCD or a debugger front
> > end for something like kdb, or a network dump module, or ...
> 
> And if it isn't a kernel why not load it as a module?  The code
> has to come preloaded anyway.

You may want to load it as a module or via syscall request. Doesn't
matter which really. But you do want all the intelligence in the loaded
code not in the reboot stub of the dying code.

