Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVCRGj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVCRGj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 01:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVCRGj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 01:39:57 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:14042 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261476AbVCRGjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 01:39:54 -0500
Date: Thu, 17 Mar 2005 22:38:53 -0800
To: andersen@codepoet.org, Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BKCVS broken ?
Message-ID: <20050318063853.GA30603@bitmover.com>
Mail-Followup-To: lm@bitmover.com, andersen@codepoet.org,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050317144522.GK22936@hottah.alcove-fr> <20050318001053.GA23358@bitmover.com> <20050318055040.GA16780@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318055040.GA16780@codepoet.org>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 10:50:40PM -0700, Erik Andersen wrote:
> On Thu Mar 17, 2005 at 04:10:53PM -0800, Larry McVoy wrote:
> > I got swamped, I'll look at this after dinner.  But you might take a look
> > at this: http://www.bitkeeper.com/press/2005-03-17.html which is a link
> > to a very simple open source BK client.  It doesn't do much except track
> > the head of the tree but it does that well.  It's slightly better than
> > that, it puts all the checkin comments in BK/ChangeLog so you don't have
> > to go over the wire to get those.
> > 
> > It's intended for someone who just wants the latest and greatest snapshot,
> > knows how to do cp -rp and diff -Nur, it's pretty basic.  It's not a
> > CVS gateway replacement but it does work for every tree on bkbits.net.
> > Just to be clear, we are not dropping the CVS gateway, this is "in
> > addition to" not "instead of".
> 
> Thanks!  Its nice to finally have an open source tool for sucking
> down the latest and greatest directly from bk.  Thus far the tool
> is working perfectly at fetching source trees and at updating
> them when new patches are applied.

Great.  It _should_ just work, I tested it with patches that included
binaries which changed, it handles that.  I suspect we'll find some
case which doesn't work some day (symlinks can't be represented in 
a patch for example) but you can always reget things from scratch,
that will work for contents, permissions, symlinks, the works.

> One minor nit.  The name for the 'update' tool is a bit too
> generic...  

Hey, it's open source, I'm hoping that people will take that code and
evolve it do whatever they need.  We're willing to do what we can on
this end if people need protocol changes to support new features, 
time permitting.  Think of that code as a prototype.  It's really
simple, you can hack it trivially.

If you want us to distribute your changes then send a patch, if not
that's cool too.  You can take that and evolve it to your heart's
content.  If you need a different license to start hacking let me
know what you want, I really don't care, you can have that code 
as public domain if you like.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
