Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUEQR6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUEQR6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUEQR6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:58:41 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:46295 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261976AbUEQR6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:58:35 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: lm@bitmover.com, Andrew Morton OSDL <akpm@osdl.org>, adi@bitmover.com,
       scole@lanl.gov, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1084808155.952.706.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 May 2004 11:35:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:

> But the bigger problem is that you are missing the point
> that I mentioned elsewhere, we are writing to a tmp file,
> the tmp file is NOT mmapped. We mmap only after that file
> is closed and renamed.  We don't map the tmp file.

Recent glibc versions will sometimes use mmap() for stdio.


