Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVCVPj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVCVPj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVCVPj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:39:28 -0500
Received: from mail.shareable.org ([81.29.64.88]:27541 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261376AbVCVPat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:30:49 -0500
Date: Tue, 22 Mar 2005 15:30:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Chris Morgan <cmorgan@alum.wpi.edu>, paul@linuxaudiosystems.com,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: kernel bug: futex_wait hang
Message-ID: <20050322153021.GA7223@mail.shareable.org>
References: <1111463950.3058.20.camel@mindpipe> <20050321202051.2796660e.akpm@osdl.org> <20050322044838.GB32432@mail.shareable.org> <1111468549.3058.36.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111468549.3058.36.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-03-22 at 04:48 +0000, Jamie Lokier wrote:
> > I argued for fixing Glibc on the grounds that the changed kernel
> > behaviour, or more exactly having Glibc depend on it, loses a certain
> > semantic property useful for unusual operations on multiple futexes at
> > the same time.  But I appear to have lost the argument, and Jakub's
> > latest patch does clean up some cruft quite nicely, with no expected
> > performance hit.
> 
> A glibc fix will take forever to get to users compared to a kernel fix.

Interesting perspective.  On my systems Glibc is upgraded more often
than the kernel.

-- Jamie
