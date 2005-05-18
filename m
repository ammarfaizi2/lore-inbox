Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVERSYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVERSYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVERSVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:21:46 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:62803 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262267AbVERSVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:21:22 -0400
Date: Wed, 18 May 2005 20:22:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Christopher Li <lkml@chrisli.org>, linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
Message-ID: <20050518182250.GB8130@mars.ravnborg.org>
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B7143.4090607@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 11:45:55AM -0500, Timur Tabi wrote:
> Christopher Li wrote:
> 
> >I think I know that it is. There is a "-nostdinc" in the sparse
> >options, which I saw it in the other email you send out. It
> >drop the internal include path. Gcc is does the same thing.
> >
> >gcc -c -nostdinc /tmp/test.c
> >/tmp/test.c:1:22: no include path in which to find stdarg.h
> 
> That option is set in the a_flags variable.  I'm looking through the kbuild 
> files (Makefile, etc) to see why a_flags is being used to build my driver.

Can you post a copy of you makefile. Then I may be able to tell you why.

	Sam
