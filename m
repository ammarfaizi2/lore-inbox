Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVAHWvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVAHWvd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVAHWvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:51:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23493 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261223AbVAHWvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:51:25 -0500
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: paulmck@us.ibm.com
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       dipankar@in.ibm.com
In-Reply-To: <20050108183220.GA2033@us.ibm.com>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com>
	 <20050108183220.GA2033@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105215021.10519.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 21:46:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-08 at 18:32, Paul E. McKenney wrote:
> What:	call_rcu(), call_rcu_bh(), and synchronize_kernel() change from
> 	EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
> When:	January 9, 2006
> Files:  kernel/rcupdate.c
> Why:	There are no known environments supporting RCU from which
> 	one could reasonably expect to port a non-GPL kernel module
> 	or driver to Linux.

IBM might want to also note that anyone wanting to do so needs an IBM
patent license for non GPL use ..

