Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWDACtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWDACtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 21:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDACtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 21:49:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:64166 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750861AbWDACtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 21:49:02 -0500
X-Authenticated: #14349625
Subject: Re: [RFC] sched.c : procfs tunables
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
In-Reply-To: <200603311723.49049.a1426z@gawab.com>
References: <200603311723.49049.a1426z@gawab.com>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 04:49:39 +0200
Message-Id: <1143859779.7762.56.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 17:23 +0300, Al Boldi wrote:
> Proper scheduling in a multi-tasking environment is critical to the success 
> of a desktop OS.  Linux, being mainly a server OS, is currently tuned to 
> scheduling defaults that may be appropriate only for the server scenario.
> 
> To enable Linux to play an effective role on the desktop, a more flexible 
> approach is necessary.  An approach that would allow the end-User the 
> freedom to adjust the OS to the specific environment at hand.
> 
> So instead of forcing a one-size fits all approach on the end-User, would not 
> exporting sched.c tunables to the procfs present a flexible approach to the 
> scheduling dilemma?

Nope, not the existing tunables anyway.  The full effect of even a tiny
scheduler knob tweak is hard to predict even if you've studied the code
carefully.  These knobs are just not generic enough to be exposed IMHO.

	-Mike

