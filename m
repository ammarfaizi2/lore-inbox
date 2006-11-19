Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933123AbWKSTzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123AbWKSTzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933126AbWKSTzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:55:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933123AbWKSTzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:55:15 -0500
Date: Sun, 19 Nov 2006 11:54:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
 SOFTWARE_SUSPEND
In-Reply-To: <200611191955.23782.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0611191153200.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <200611191844.14354.rjw@sisk.pl>
 <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org> <200611191955.23782.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2006, Rafael J. Wysocki wrote:
> 
> > because people point to the suspend-to-disk instead.
> 
> Who they?

Like you _just_ did.

> >  - enable PM_DEBUG, and PM_TRACE
> 
> This only works on i386, no?

Right now the trivial functions are only available on i386, yes. The 
concept works anywhere that has a CMOS chip, so if somebody were to spend 
a few minutes testing it on x86-64 and others, it would work elsewhere 
too..

> I don't know of anyone who's doing that.

I know. I'm probably the only one. Frustrating.

		Linus
