Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVAIG1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVAIG1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 01:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVAIG1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 01:27:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:25485 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262262AbVAIG1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 01:27:47 -0500
Date: Sat, 8 Jan 2005 22:27:31 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       dipankar@in.ibm.com
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050109062731.GD1265@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com> <20050108183220.GA2033@us.ibm.com> <1105215021.10519.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105215021.10519.50.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 09:46:34PM +0000, Alan Cox wrote:
> On Sad, 2005-01-08 at 18:32, Paul E. McKenney wrote:
> > What:	call_rcu(), call_rcu_bh(), and synchronize_kernel() change from
> > 	EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
> > When:	January 9, 2006
> > Files:  kernel/rcupdate.c
> > Why:	There are no known environments supporting RCU from which
> > 	one could reasonably expect to port a non-GPL kernel module
> > 	or driver to Linux.
> 
> IBM might want to also note that anyone wanting to do so needs an IBM
> patent license for non GPL use ..

Last time I checked with IBM's lawyers, they were not interested in doing
so.  Nonetheless, you are correct, non-GPL use of RCU would require a
conversation with IBM.  And in fact the five relevant patents (one lapsed)
are called out in Documentation/RCU/RTFP.txt.  The four non-lapsed patents
are called out as "contributed under GPL", so I think that we are covered.

							Thanx, Paul
