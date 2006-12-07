Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163551AbWLGWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163551AbWLGWmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163534AbWLGWmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:42:03 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:47442 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163551AbWLGWmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:42:00 -0500
Date: Thu, 7 Dec 2006 14:42:02 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Theodore Tso <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 21/35] Unionfs: Inode operations
Message-Id: <20061207144202.9f0647ba.randy.dunlap@oracle.com>
In-Reply-To: <20061207090715.5e34babc.akpm@osdl.org>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
	<11652354711835-git-send-email-jsipek@cs.sunysb.edu>
	<Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
	<20061205135017.3be94142.akpm@osdl.org>
	<20061207140427.GC31773@thunk.org>
	<20061207090715.5e34babc.akpm@osdl.org>
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

On Thu, 7 Dec 2006 09:07:15 -0800 Andrew Morton wrote:

> On Thu, 7 Dec 2006 09:04:27 -0500
> Theodore Tso <tytso@mit.edu> wrote:
> 
> > On Tue, Dec 05, 2006 at 01:50:17PM -0800, Andrew Morton wrote:
> > > This
> > > 
> > > 	/*
> > > 	 * Lorem ipsum dolor sit amet, consectetur
> > > 	 * adipisicing elit, sed do eiusmod tempor
> > > 	 * incididunt ut labore et dolore magna aliqua.
> > > 	 */
> > > 
> > > is probably the most common, and is what I use when forced to descrog
> > > comments.
> > 
> > This what I normally do by default, unless it's a one-line comment, in
> > which case my preference is usually for this:
> > 
> > /* Lorem ipsum dolor sit amet, consectetur */
> 
> yup.
> 
> > I'm not convinced we really do _need_ to standardize on comment styles
> > (I can foresee thousands and thousands of trivial patches being
> > submitted and we'd probably be better off encouraging people to spend
> > time actually improving the documentation instead of reformatting it :-), 
> > but if were going to standardize, that would be my vote.
> 
> Sure.  comment-relaying-out patches would not be particularly welcome ;)

I third that.  Not a janitors (or anyone's) task/busy-work.

---
~Randy
