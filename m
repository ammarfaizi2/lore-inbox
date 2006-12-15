Return-Path: <linux-kernel-owner+w=401wt.eu-S1751017AbWLOAZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWLOAZi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWLOAZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:25:37 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:37396 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbWLOAZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:25:12 -0500
Date: Thu, 14 Dec 2006 16:26:05 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
Message-Id: <20061214162605.b4b6f9f8.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612141906270.27378@localhost.localdomain>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
	<20061214223850.GC25114@vasa.acc.umu.se>
	<4581D355.1000701@oracle.com>
	<Pine.LNX.4.64.0612141906270.27378@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 19:07:27 -0500 (EST) Robert P. J. Day wrote:

> On Thu, 14 Dec 2006, Randy Dunlap wrote:
> 
> > David Weinehall wrote:
> > > On Thu, Dec 07, 2006 at 12:48:38AM -0800, Randy Dunlap wrote:
> > >
> > > [snip]
> > >
> > > > +but no space after unary operators:
> > > > +		sizeof  ++  --  &  *  +  -  ~  !  defined
> > >
> > > Uhm, that doesn't compute...  If you don't put a space after sizeof,
> > > the program won't compile.
> > >
> > > int c;
> > > printf("%d", sizeofc);
> >
> > Uh, we prefer not to see "sizeof c".  IOW, we prefer to have the
> > parentheses use all the time.  Maybe I need to say that better?
> 
> here's a *really* rough first pass, i'm sure the end result would need
> some hand tweaking:

You can certainly send such (generated) patches to Andrew or other
subsystem maintainers if you'd like, but I'm more interested in
not adding more crud to the tree in the future.

IOW, sure, we prefer sizeof(foo) to sizeof foo, but the latter isn't
killing us.  If someone is there making other changes, it would be
OK to change that also.

Compare:  http://lkml.org/lkml/2006/12/7/191

---
~Randy
