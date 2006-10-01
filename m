Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWJAR13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWJAR13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJAR13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:27:29 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:64530 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932078AbWJAR12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:27:28 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: Announce: gcc bogus warning repository
Date: Sun, 1 Oct 2006 18:27:29 +0100
User-Agent: KMail/1.9.4
Cc: Randy Dunlap <rdunlap@xenotime.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <451FC657.6090603@garzik.org> <20061001100747.d1842273.rdunlap@xenotime.net> <451FF8ED.9080507@garzik.org>
In-Reply-To: <451FF8ED.9080507@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011827.29732.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 18:20, Jeff Garzik wrote:
> Randy Dunlap wrote:
[snip]
> >> This repository will NEVER EVER be pushed upstream.  It exists solely
> >> for those who want to decrease their build noise, thereby exposing true
> >> bugs.
> >>
> >> The audit has already uncovered several minor bugs, lending credence to
> >> my theory that too many warnings hides bugs.
> >
> > I usually build with must_check etc. enabled then grep them
> > away if I want to look for other messages.  I think that the situation
> > is not so disastrous.
>
> I think it's both sad, and telling, that the high level of build noise
> has trained kernel hackers to tune out warnings, and/or build tools of
> ever-increasing sophistication just to pick out the useful messages from
> all the noise.
>
> If you have to grep useful stuff out of the noise, you've already lost.

The question is whether the GCC guys are actually doing anything about the 
problem. If they are, we should do nothing. If they aren't, maybe it's time 
for "x = x" hacks like Steven's.

Is GCC 4.2 any better with this class of warnings?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
