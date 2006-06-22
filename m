Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWFVSqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWFVSqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWFVSqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:46:19 -0400
Received: from xenotime.net ([66.160.160.81]:15763 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751819AbWFVSqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:46:19 -0400
Date: Thu, 22 Jun 2006 11:49:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-Id: <20060622114900.6f1c6a5f.rdunlap@xenotime.net>
In-Reply-To: <20060622183021.GA5857@kroah.com>
References: <20060621220656.GA10652@kroah.com>
	<Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
	<20060621225134.GA13618@kroah.com>
	<Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
	<20060622181826.GB22867@kroah.com>
	<20060622183021.GA5857@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 11:30:21 -0700 Greg KH wrote:

> On Thu, Jun 22, 2006 at 11:18:26AM -0700, Greg KH wrote:
> > On Wed, Jun 21, 2006 at 06:22:58PM -0700, Linus Torvalds wrote:
> > > And as usual, the diff options work fine with "git log" too, so you can do
> > > 
> > > 	git log -M --stat --summary
> > > 
> > > and it will do the right thing. Look at your ae0dadcf.. commit, for 
> > > example.
> > > 
> > > Btw, the _one_ thing to be careful about is that when you generate a real 
> > > patch with "-M", if that patch actually has a rename, then only "git 
> > > apply" will be able to apply it correctly, and if somebody uses a regular 
> > > "patch" program to apply it, they'll miss out on the rename, of course.
> > > 
> > > Some day maybe the git "extended patch format" is so univerally recognized 
> > > to be superior that everybody understands them, in the meantime you may 
> > > not want to use "-M" to generate patches unless you know the other end 
> > > applies them with git.
> > > 
> > > (Which also explains why "-M" is not the default, of course).
> > 
> > For now I'll leave -M off, as people might want to apply the patches
> > from email.  Although it might cut down on main bandwidth, and they can
> > always refer to the git tree or original patch...  I'll think about that
> > one.
> 
> I take that back.  I just used -M for the W1 patch series and I think it
> is very helpful as it shows only the lines that change in a rename,
> which can easily get lost in the noise of a longer patch.
> 
> Very nice stuff, have I mentioned lately how much I love git?

Um, I was going to say that my patch wasn't listed in the
shortlog that you sent (for W1), but it's there, just mis-attributed
to Evgeniy (#13/14).

---
~Randy
