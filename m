Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbTEQBOk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 21:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTEQBOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 21:14:40 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:43489 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S264641AbTEQBOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 21:14:39 -0400
Date: Fri, 16 May 2003 21:23:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.5.69-mm6
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ch@murgatroid.com, Andrew Morton <akpm@digeo.com>
Message-ID: <200305162126_MC3-1-3947-176E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > I'd vote for treating this patch just like the futexes one, making sure that
> > those who know *how* can turn epoll off, but leave it out of make config.
> > 
> > Furthermore, I wonder if this patch is a large savings, the bulk of epoll is
> > infrastructure, not the few syscalls.
>
> All of this stuff should be disablable and far more. It probably all
> wants hiding under a single "Shrink feature set" type option most people
> can skip over as they do with kernel debugging.


  What else should be disablable?



