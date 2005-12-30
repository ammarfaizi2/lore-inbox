Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVL3Tws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVL3Tws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVL3Tws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:52:48 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:62903 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932214AbVL3Tws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:52:48 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Date: Fri, 30 Dec 2005 19:53:02 +0000
User-Agent: KMail/1.9
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229231615.GV15993@alpha.home.local>
In-Reply-To: <20051229231615.GV15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512301953.02998.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 December 2005 23:16, Willy Tarreau wrote:
> On Thu, Dec 29, 2005 at 09:41:12AM -0800, Linus Torvalds wrote:
> > There have been situations where documented gcc semantics changed, and
> > instead of saying "sorry", the gcc people changed the documentation. What
> > the hell is the point of documented semantics if you can't depend on them
> > anyway?
>
> Remember the #arg and ##arg mess in macros between gcc2 and gcc3 ?
>
> I fell like I start to understand where your hate for specifications
> comes from. As much as I like to stick to specs, which is generally
> OK for hardware and network protocols, I can say that with GCC, there
> is clearly no rule telling you whether your program will still compile
> with version N+1 or not.
>
> Can't we elect a recommended gcc version that distro makers could
> ship under the name kgcc as it has been the case for some time,
> and try to stick to that version for as long as possible ? The only
> real reason to upgrade it would be to support newer archs, while at
> the moment, we try to support compilers which are shipped as default
> *user-space* compilers.

Leave this decision to distributors. Ubuntu already seem to use (and require 
you to install) gcc 3.4 if you want to recompile their kernel or any kernel 
modules. It ships with 4.0.1, iirc.

I see GCC improving currently. 3.0 was horrendously slow and buggy versus 
2.95, but 3.3 was a very good compiler, and 4.1 looks like it will be even 
better. Maybe things will continue to improve and this will become less of an 
issue over time.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
