Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVDJKSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVDJKSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVDJKSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:18:23 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:42119 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261463AbVDJKST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:18:19 -0400
Date: Sun, 10 Apr 2005 03:09:09 -0400
From: Christopher Li <lkml@chrisli.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050410070909.GE13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <20050410055340.GB13853@64m.dyndns.org> <20050410094153.GA26537@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410094153.GA26537@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 11:41:53AM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Apr 10, 2005 at 07:53:40AM CEST, I got a letter
> where Christopher Li <lkml@chrisli.org> told me that...
> > On Sun, Apr 10, 2005 at 12:51:59AM -0700, Junio C Hamano wrote:
> > > 
> > > But I am wondering what your plans are to handle renames---or
> > > does git already represent them?
> > >
> > 
> > Rename should just work.  It will create a new tree object and you
> > will notice that in the entry that changed, the hash for the blob
> > object is the same.
> 
> Which is of course wrong when you want to do proper merging, examine
> per-file history, etc. One solution which springs to my mind is to have
> a UUID accompany each blob and tree; that will take relatively lot of
> space though, and I'm not sure it is really worth it.

It should just use the rename + change two step then it is tractable
with git now.

Chris
