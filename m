Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263302AbVCDXwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbVCDXwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbVCDXt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:49:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:37802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263302AbVCDWgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:36:15 -0500
Date: Fri, 4 Mar 2005 14:36:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-Id: <20050304143614.203278fd.akpm@osdl.org>
In-Reply-To: <20050304220518.GC1201@kroah.com>
References: <20050304175302.GA29289@kroah.com>
	<20050304124431.676fd7cf.akpm@osdl.org>
	<20050304205842.GA32232@kroah.com>
	<20050304131537.7039ca10.akpm@osdl.org>
	<Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org>
	<20050304135933.3a325efc.akpm@osdl.org>
	<20050304220518.GC1201@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Fri, Mar 04, 2005 at 01:59:33PM -0800, Andrew Morton wrote:
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > 
> > > 
> > > On Fri, 4 Mar 2005, Andrew Morton wrote:
> > > > > 
> > > > >  Ok, care to forward them on?
> > > > 
> > > > Sure.  How do they get to Linus?
> > > 
> > > I'll just pull from the sucker-tree. 
> > > 
> > 
> > That tree has the not-for-linus raid6 fix and the not-for-linus i8042 fix.
> 
> Then when the authors of those patches go to submit the fix to Linus,
> they can revert them, or bk can handle the merge properly :)
> 

Well yeah.  That's what I mentioned yesterday - I revert the notfix while
merging up the realfix.

OK for really small stuff, but it could get messy.  We'll see.

But we end up with a cset in the permanent kernel history which simply
should not have been there.
