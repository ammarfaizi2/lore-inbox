Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVBYCKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVBYCKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVBYCKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:10:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:29392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262596AbVBYCKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:10:49 -0500
Date: Thu, 24 Feb 2005 18:10:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@osdl.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set RLIMIT_SIGPENDING limit based on RLIMIT_NPROC
Message-ID: <20050225021038.GT15867@shell0.pdx.osdl.net>
References: <421D0D3F.40902@goop.org> <200502240224.j1O2OqHL010736@magilla.sf.frob.com> <20050224030747.GG15867@shell0.pdx.osdl.net> <421E87E7.4080601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E87E7.4080601@goop.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> 
> >It's an rlimit, so easily setable in userspace at login session time.  I
> >think we could raise it if people start complaining it's too low (hasn't
> >seemed to be a problem yet).
> >
> Know any shells which support setting it?  Indeed, glibc doesn't seem to
> know about it.

Hrm, my bash and glibc are both aware, you might need an update?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
