Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWHaSBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWHaSBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWHaSBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:01:52 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37507 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932429AbWHaSBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:01:51 -0400
Date: Thu, 31 Aug 2006 11:00:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: rwlock.h fix smp alternatives fix
Message-ID: <20060831180018.GB20873@sequoia.sous-sol.org>
References: <200608311221_MC3-1-C9EE-3548@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608311221_MC3-1-C9EE-3548@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Ebbert (76306.1226@compuserve.com) wrote:
> In-Reply-To: <200608311011.45844.ak@suse.de>
> 
> On Thu, 31 Aug 2006 10:11:45 +0200, Andi Kleen wrote:
> 
> > Here's the patch as intended for reference :/ Or Chris' incremental
> > is fine.
> > 
> > i386: Remove alternative_smp
> > 
> > The .fill causes miscompilations with some binutils version.
> 
> Has the dust settled enough to prepare a patch for -stable now?

Seems so, although Linus hasn't fixed upstream yet.  The binutils
issues look worrisome enough, miscompilation should certainly be fixed
in -stable.  And we should get both i386 and the x86_64 fix as well.
I'll add those unless Andi objects.

thanks,
-chris
