Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWJRE0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWJRE0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWJRE0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:26:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:27866 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932072AbWJRE0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:26:08 -0400
Subject: Re: [PATCH 1/1] lseek - SEEK_HOLE/SEEK_DATA support
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Eric L <e.codemonkey@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <946a3fda0610171929m5b656be8r60c3e3241062ad27@mail.gmail.com>
References: <946a3fda0610161830u2070c903h7faa93d2dda3786f@mail.gmail.com>
	 <1161092211.14171.22.camel@kleikamp.austin.ibm.com>
	 <946a3fda0610171929m5b656be8r60c3e3241062ad27@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 23:26:00 -0500
Message-Id: <1161145562.23979.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 21:29 -0500, Eric L wrote:

> > vfs_lseek.patch:
> >
> > Can you add definititions of SEEK_HOLE and SEEK_DATA to fs.h?  I really
> > don't like that the code doesn't use the symbolic constants.
> >
> 
> Agreed.  When I originally wrote it against 2.6.17.7, I couldn't find
> any precedent for adding such defines, but I see they are in 2.6.18.1
> at least.

Yeah, I realize the original code used 1 & 2, but this is a good
opportunity to improve that.

> 
> Thanks for the comments.  I've made these changes.  Should I resubmit
> it to the mailing list (inline this time)?

Yeah, that would be great.  You may get a bigger response if you cc'ed
linux-kernel@vger.kernel.org as well.

> - Eric
-- 
David Kleikamp
IBM Linux Technology Center

