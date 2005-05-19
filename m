Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVESNZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVESNZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVESNZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:25:48 -0400
Received: from users.ccur.com ([208.248.32.211]:24697 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S262487AbVESNZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:25:42 -0400
Date: Thu, 19 May 2005 09:24:57 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andi Kleen <ak@muc.de>
Cc: robustmutexes@lists.osdl.org, george@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] A more general timeout specification
Message-ID: <20050519132457.GA9357@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20050518201517.GA16193@tsunami.ccur.com> <m1hdh0yu14.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdh0yu14.fsf@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 01:49:11AM +0200, Andi Kleen wrote:
> Joe Korty <joe.korty@ccur.com> writes:
> 
> > The fusyn (robust mutexes) project proposes the creation
> > of a more general data structure, 'struct timeout', for the
> > specification of timeouts in new services.  In this structure,
> > the user specifies:
> >
> >     a time, in timespec format.
> >     the clock the time is specified against (eg, CLOCK_MONOTONIC).
> >     whether the time is absolute, or relative to 'now'.
> 
> If you do a new structure for this I would suggest adding a
> "precision" field (or the same with a different name). Basically
> precision would tell the kernel that the wakeup can be in a time
> range, not necessarily on the exact time specified.

Very cool.
Joe
