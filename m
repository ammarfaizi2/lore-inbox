Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbULAWal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbULAWal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULAWal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:30:41 -0500
Received: from users.ccur.com ([208.248.32.211]:39419 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261471AbULAWa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:30:29 -0500
Date: Wed, 1 Dec 2004 17:30:14 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, kortyads@mindspring.com,
       linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
Message-ID: <20041201223014.GA3271@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20041130202730.6ceab259.akpm@osdl.org> <200412011920.iB1JKlug004542@magilla.sf.frob.com> <20041201114141.7f3347a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201114141.7f3347a1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 11:41:41AM -0800, Andrew Morton wrote:
> Roland McGrath <roland@redhat.com> wrote:
> >
> > I've had no luck reproducing that, so there isn't much I can do.
> 
> Did you try bare 2.6.10-rc2?
> 
> >  The last
> > time someone thought the waitid change broke something random, it was the
> > perturbation of the compiled code vs the issue that the kernel's assembly
> > code doesn't follow the same calling conventions the compiler expects.
> 
> Could be that, but I was able to reproduce it on 2.6.10-rc2 with
> gcc-2.95.4, with which -mregparm is disabled.
> 
> Still.  It would be interesting if Joe could retest with CONFIG_REGPARM=n?

CONFIG_REGPARM is not set in all of my kernels (just verified).
Joe
