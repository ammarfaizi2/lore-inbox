Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWB1V0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWB1V0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWB1V0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:26:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932495AbWB1V0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:26:14 -0500
Date: Tue, 28 Feb 2006 13:25:38 -0800
From: Richard Henderson <rth@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch] i386: make bitops safe
Message-ID: <20060228212538.GA28302@redhat.com>
References: <200602280106_MC3-1-B974-9231@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602280106_MC3-1-B974-9231@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 01:04:01AM -0500, Chuck Ebbert wrote:
> > One could reasonably argue that if you used a structure with a
> > flexible array member, that GCC could not look through that.  But
> > again I'm not 100% positive this is handled properly.
> 
> This seems to work but causes more problems than it solves:
> 
> #define vaddr ((volatile long *) addr)

This isn't a structure witha flexible array member.


r~
