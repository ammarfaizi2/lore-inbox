Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVAHXEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVAHXEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVAHXEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:04:21 -0500
Received: from canuck.infradead.org ([205.233.218.70]:17158 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261290AbVAHXED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:04:03 -0500
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: paulmck@us.ibm.com, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       dipankar@in.ibm.com
In-Reply-To: <1105215021.10519.50.camel@localhost.localdomain>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com>
	 <20050108183220.GA2033@us.ibm.com>
	 <1105215021.10519.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 00:03:45 +0100
Message-Id: <1105225426.4196.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-08 at 21:46 +0000, Alan Cox wrote:
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

given this, I actually think it might be better to make it a _GPL export
right away, anything else is setting people up in an entrapment kind of
way.


