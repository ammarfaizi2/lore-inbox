Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWHTWgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWHTWgy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWHTWgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:36:54 -0400
Received: from mx2.rowland.org ([192.131.102.7]:29968 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751204AbWHTWgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:36:54 -0400
Date: Sun, 20 Aug 2006 18:36:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Jeff Garzik <jeff@garzik.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
In-Reply-To: <Pine.LNX.4.61.0608210005090.32565@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.44L0.0608201834430.12027-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, Jan Engelhardt wrote:

> >> Recently introduced "bool".
> >
> >I haven't seen the new definition of "bool", but it can't possibly provide 
> >a strong distinction between integers and booleans.  That is, if x is 
> >declared as an integer rather than as a bool, the compiler won't complain 
> >about "if (x) ...".
> 
> Only Java will get you this distinction.

Not true.  It exists in Ruby.  :-)

> I would be comfortable with a 
> feature where conditionals (like if() and ?:) enforce a bool showing 
> up in C/C++, but it's not easy to get into the mainline gcc.

I think relying on an agreed-upon convention is the best we can do.

Alan Stern

