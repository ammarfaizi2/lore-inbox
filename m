Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTEVIPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTEVIPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:15:13 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:37252 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262568AbTEVIPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:15:12 -0400
Date: Thu, 22 May 2003 01:31:01 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-Id: <20030522013101.7181cdb0.akpm@digeo.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2B5@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A2B5@orsmsx401.jf.intel.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 08:28:15.0523 (UTC) FILETIME=[17298730:01C3203C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> wrote:
>
> 
> > From: Andrew Morton [mailto:akpm@digeo.com] 
> 
> Hi just wanted to add some comments below:

Appreciated, thanks.

> >  drivers/acpi/
> >  ~~~~~~~~~~~~~
> >  
> >  o davej: ACPI has a number of failures right now.  There are 
> ...
> 
> Working on these (they're all in bugzilla), more help needed of course
> :)

OK, well if they're safely bugzilla'd I shall remove them from here. 
Unless you think they're drop-dead stop-ship material.

> > +o mochel: it seems the acpi irq routing code could use a 
> > serious rewrite.
> 
> No the problem is the ACPI irq routing code is trying to piggyback on
> the existing MPS-specific data structures, and it's generally a hack. So
> yes mochel is right, but it is also purging MPS-ities from common code
> as well. I've done some preliminary work in this area and it doesn't
> seem to break anything (yet) but a rewrite in this area imho should not
> be rushed out the door. And, I think the above bugs can be fixed w/o the
> rewrite.

Where do you think this work sits on the seriousness scale?  Is it
affecting a lot of people?  Is it a large-scale restructure?

It sounds to me like it's a non-trivial piece of ACPI brain surgery and
that I should continue to track it, yes?

