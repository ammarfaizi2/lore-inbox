Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945988AbWBOPnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945988AbWBOPnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945989AbWBOPnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:43:51 -0500
Received: from kanga.kvack.org ([66.96.29.28]:37057 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1945988AbWBOPnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:43:50 -0500
Date: Wed, 15 Feb 2006 10:38:59 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: fix make -jN with multiple targets with O=...
Message-ID: <20060215153859.GB12370@kvack.org>
References: <200601170510.k0H5AtSJ005682@hera.kernel.org> <20060215040433.GA17334@kvack.org> <20060214201257.479cb4fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214201257.479cb4fc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 08:12:57PM -0800, Andrew Morton wrote:
> Benjamin LaHaise <bcrl@kvack.org> wrote:
> >
> > Hello folks,
> > 
> > This patch causes a ~95% increase in build time for the kernel.  Before: 
> > 4m21s after: 8m1.403s.  Can we revert this until another approach is found?
> > 
> 
> Yowch.  Is that with a regular old build-in-place, or is it specific to
> out-of-tree builds, or what?

It's just a plain old x86-64 build in place on Fedora.  I'm game for 
testing any alternatives, but my kbuild-foo is not good enough to 
discern what the patch is trying to do and why it makes make unhappy.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
