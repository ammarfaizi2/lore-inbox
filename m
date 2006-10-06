Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWJFWnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWJFWnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWJFWnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:43:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932654AbWJFWnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:43:00 -0400
Date: Fri, 6 Oct 2006 15:42:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fdtable: Extensive fs/file.c cleanups.
Message-Id: <20061006154254.e9d584d0.akpm@osdl.org>
In-Reply-To: <200610061438.07702.vlobanov@speakeasy.net>
References: <200610052152.29013.vlobanov@speakeasy.net>
	<20061006132258.39fc58ed.akpm@osdl.org>
	<200610061438.07702.vlobanov@speakeasy.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 14:38:07 -0700
Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> On Friday 06 October 2006 13:22, Andrew Morton wrote:
> > On Thu, 5 Oct 2006 21:52:28 -0700
> >
> > Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > > As long as the previous patch replaces the guts of fs/file.c, it makes
> > > sense to tidy up all the code within. This work includes:
> > > 	code simplification via refactoring,
> > > 	elimination of unnecessary code paths,
> > > 	extensive commenting throughout the entire file, and
> > > 	other minor cleanups and consistency tweaks.
> > > This patch does not contain any functional modifications.
> > >
> > > This is the last patch in the series. All the code should now be sparkly
> > > clean.
> >
> > This (wordwrapped) patch should have been the first in the series, not the
> > last.
> 
> Didn't know. Was hoping to gather this kind of feedback after the first 
> submission attempt.
> 
> > So I'll drop this one.
> 
> This patch still has a lot of useful (and I'd argue necessary) fixes for 
> incorrect comments and confusing code ordering. It's especially nice for 
> those who might try to understand what's going on inside fs/file.c, so seems 
> a shame to drop it. I could...
> 	... hold on to it until the other fdtable changes hit mainline.
> 		or
> 	... redo this one with just the bare essentials.
> 		or
> 	... drop it completely.

                or
        ... redo the patches so this one comes first.

Which sounds like a hassle.  If it's too much hassle, your option 1 sounds
OK.
