Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVAIGXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVAIGXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 01:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVAIGXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 01:23:41 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28908 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262264AbVAIGXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 01:23:40 -0500
Date: Sat, 8 Jan 2005 22:23:25 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       dipankar@in.ibm.com
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050109062324.GC1265@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com> <20050108183220.GA2033@us.ibm.com> <1105215021.10519.50.camel@localhost.localdomain> <1105225426.4196.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105225426.4196.41.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 12:03:45AM +0100, Arjan van de Ven wrote:
> On Sat, 2005-01-08 at 21:46 +0000, Alan Cox wrote:
> > On Sad, 2005-01-08 at 18:32, Paul E. McKenney wrote:
> > > What:	call_rcu(), call_rcu_bh(), and synchronize_kernel() change from
> > > 	EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
> > > When:	January 9, 2006
> > > Files:  kernel/rcupdate.c
> > > Why:	There are no known environments supporting RCU from which
> > > 	one could reasonably expect to port a non-GPL kernel module
> > > 	or driver to Linux.
> > 
> > IBM might want to also note that anyone wanting to do so needs an IBM
> > patent license for non GPL use ..
> 
> given this, I actually think it might be better to make it a _GPL export
> right away, anything else is setting people up in an entrapment kind of
> way.

There could be no entrapment unless IBM chose to go after people who used
RCU from a binary module.

							Thanx, Paul
