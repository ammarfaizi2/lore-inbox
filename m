Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWHKT27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWHKT27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWHKT26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:28:58 -0400
Received: from 1wt.eu ([62.212.114.60]:52493 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932251AbWHKT2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:28:55 -0400
Date: Fri, 11 Aug 2006 21:09:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.33 released
Message-ID: <20060811190923.GJ8776@1wt.eu>
References: <200608110418.k7B4IqDn017355@hera.kernel.org> <1155318180.23933.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155318180.23933.7.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Aug 11, 2006 at 07:43:00PM +0200, Kasper Sandberg wrote:
> On Fri, 2006-08-11 at 04:18 +0000, Marcelo Tosatti wrote:
> > final:
> > 
> > - 2.4.33-rc3 was released as 2.4.33 with no changes.
> I have one suggestion for the 2.4 tree, next time a few changes is
> introduced, they could be put as a bugfix release, as with the 2.6
> branch now, so that it doesent end up taking years for a new 2.4
> release, and instead a point release(if any such thing happens at all)

This has already the case with the hotfix tree since 18 months or so. A
hotfix release is issued when there are important fixes. Anyway, I was
thinking about releasing pre-releases more often. Also, you might have
noticed that the slowdown is more important during -rc for obvious reasons.
To solve this problem, I intend to maintain a 'next' branch in the tree
which will contain the fixes that can wait for next version. It should
help us batch the fixes and reduce the latency between important fixes
and the associated release.

Regards,
Willy

