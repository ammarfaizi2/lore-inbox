Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268455AbUJGVVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268455AbUJGVVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUJGVRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:17:47 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:24803 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S267740AbUJGU4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:56:40 -0400
Date: Thu, 7 Oct 2004 16:56:14 -0400
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@redhat.com, serue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-ID: <20041007205614.GA23824@escher.cs.wm.edu>
References: <20041007040859.GA17774@escher.cs.wm.edu> <Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com> <20041006232208.505ccacd.akpm@osdl.org> <20041007090645.U2357@build.pdx.osdl.net> <20041007114039.6e861b2b.akpm@osdl.org> <20041007115240.C2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007115240.C2357@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Andrew Morton (akpm@osdl.org) wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > > * Andrew Morton (akpm@osdl.org) wrote:
> > > Which feature are you concerned over, the additional hook or the
> > > new module?
> > 
> > I am concerned about the presence of new code - simple as that.
> 
> Understood.

We do have time allotted for maintenance of LSMs, so not only am I
interested in maintaining bsdjail on my own, but I don't even have to do
it in my free time  :)

> > We need to be able to demonstrate that the new code is sufficiently useful
> > to a sufficiently large number of people as to warrant the cost of
> > maintaining it in the tree for the rest of eternity.
> 
> That's fine.  Serge, can you enlighten us with an idea of the users of
> this code?

I am "just a developer", and don't have ready access to any marketers.
There was no customer demand which we were addressing.  We just saw it
as a very useful feature easy to implement.  Some people have privately
expressed interested in the patch over the last few months as I've been
sending out patches.  And as Chris has mentioned, the vserver community
appears to be thriving, and should be partially (though by no means
fully!) served by this module.  If nothing else it should reduce the
size of the patch they need to maintain.

I wish I had a better answer...

-serge
