Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUEKALp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUEKALp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEKALp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:11:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:12162 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262328AbUEKALl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:11:41 -0400
Date: Mon, 10 May 2004 17:14:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510171413.6c1699b8.akpm@osdl.org>
In-Reply-To: <20040510235312.GA9348@taniwha.stupidest.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<20040510231146.GA5168@taniwha.stupidest.org>
	<20040510162818.376b4a55.akpm@osdl.org>
	<20040510233342.GA5614@taniwha.stupidest.org>
	<20040510165132.5107472e.akpm@osdl.org>
	<20040510235312.GA9348@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Mon, May 10, 2004 at 04:51:32PM -0700, Andrew Morton wrote:
> 
> > Maybe that's the price we pay for leaving this problem unsolved for
> > a year.
> 
> I didn't know it needed solving until recently.  I guess I've been
> under a rock or something then.

It has stagnated.  I think the mindset has been "oh, we need to ship a hack
because upstream is bust" and so nobody did anything.

> > You misunderstand.  Nasty workarounds will be shipped to end users
> > by vendors.  That's a certainty.  We cannot change this now.
> 
> Vendors will support this too presumably.
> 
> > What I wish to do is to ensure that all users receive the *same*
> > nasty workaround.  Call it damage control.
> 
> How urgent is this?  Can it wait a few more weeks?  It seems people
> are new looking at this and a little more discussion won't hurt if
> it's been a year already.
> 

Migrating away from this will require work from vendors, Oracle, PAM
developers, /bin/login and /bin/su developers.  Until that has happened I
think we should arrange for vendor kernels and kernel.org kernels to offer
the same interfaces.

And I don't think pulling the feature out of kernel.org kernels will
provide any added stimulus, frankly.  They'll just ship the hack and go off
to do something else.

If someone had done the kernel and userspace work 6-12 months ago then
sure, we wouldn't be in this situation.

As to whether it is practical to jam all this work through at this stage:
dunno, really.  I doubt it.  It would be good to try though.
