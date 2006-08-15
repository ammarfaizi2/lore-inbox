Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWHOPQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWHOPQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWHOPQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:16:56 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:24788 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030338AbWHOPQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:16:56 -0400
Date: Tue, 15 Aug 2006 17:16:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: What's in kbuild.git for 2.6.19
Message-ID: <20060815151653.GA29974@mars.ravnborg.org>
References: <20560.1155614017@kao2.melbourne.sgi.com> <25740.1155623159@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25740.1155623159@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 04:25:59PM +1000, Keith Owens wrote:
 
> The jobserver in make 3.80 is buggy.  3.80 appears to work for parallel
> builds using a single Makefile, with recursive make it can lose
> jobserver tokens.  make 3.81 works fine.  Now to persuade SuSE to
> upgrade to make 3.81.
sam@mars ~ $ make --version
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for x86_64-pc-linux-gnu

That explains why I do not see it.

Thanks for investigating this!

	Sam
