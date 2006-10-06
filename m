Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422984AbWJFViM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWJFViM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422982AbWJFViM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:38:12 -0400
Received: from mail.impinj.com ([206.169.229.170]:44149 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1422983AbWJFViL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:38:11 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/5] fdtable: Extensive fs/file.c cleanups.
Date: Fri, 6 Oct 2006 14:38:07 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200610052152.29013.vlobanov@speakeasy.net> <20061006132258.39fc58ed.akpm@osdl.org>
In-Reply-To: <20061006132258.39fc58ed.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061438.07702.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 13:22, Andrew Morton wrote:
> On Thu, 5 Oct 2006 21:52:28 -0700
>
> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > As long as the previous patch replaces the guts of fs/file.c, it makes
> > sense to tidy up all the code within. This work includes:
> > 	code simplification via refactoring,
> > 	elimination of unnecessary code paths,
> > 	extensive commenting throughout the entire file, and
> > 	other minor cleanups and consistency tweaks.
> > This patch does not contain any functional modifications.
> >
> > This is the last patch in the series. All the code should now be sparkly
> > clean.
>
> This (wordwrapped) patch should have been the first in the series, not the
> last.

Didn't know. Was hoping to gather this kind of feedback after the first 
submission attempt.

> So I'll drop this one.

This patch still has a lot of useful (and I'd argue necessary) fixes for 
incorrect comments and confusing code ordering. It's especially nice for 
those who might try to understand what's going on inside fs/file.c, so seems 
a shame to drop it. I could...
	... hold on to it until the other fdtable changes hit mainline.
		or
	... redo this one with just the bare essentials.
		or
	... drop it completely.

-- Vadim Lobanov
