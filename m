Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162563AbWLGRW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162563AbWLGRW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162561AbWLGRW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:22:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47518 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162559AbWLGRWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:22:55 -0500
Date: Thu, 7 Dec 2006 09:07:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 21/35] Unionfs: Inode operations
Message-Id: <20061207090715.5e34babc.akpm@osdl.org>
In-Reply-To: <20061207140427.GC31773@thunk.org>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
	<11652354711835-git-send-email-jsipek@cs.sunysb.edu>
	<Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
	<20061205135017.3be94142.akpm@osdl.org>
	<20061207140427.GC31773@thunk.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 09:04:27 -0500
Theodore Tso <tytso@mit.edu> wrote:

> On Tue, Dec 05, 2006 at 01:50:17PM -0800, Andrew Morton wrote:
> > This
> > 
> > 	/*
> > 	 * Lorem ipsum dolor sit amet, consectetur
> > 	 * adipisicing elit, sed do eiusmod tempor
> > 	 * incididunt ut labore et dolore magna aliqua.
> > 	 */
> > 
> > is probably the most common, and is what I use when forced to descrog
> > comments.
> 
> This what I normally do by default, unless it's a one-line comment, in
> which case my preference is usually for this:
> 
> /* Lorem ipsum dolor sit amet, consectetur */

yup.

> I'm not convinced we really do _need_ to standardize on comment styles
> (I can foresee thousands and thousands of trivial patches being
> submitted and we'd probably be better off encouraging people to spend
> time actually improving the documentation instead of reformatting it :-), 
> but if were going to standardize, that would be my vote.

Sure.  comment-relaying-out patches would not be particularly welcome ;)
