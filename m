Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWDCMmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDCMmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDCMmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:42:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:36324 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932290AbWDCMmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:42:24 -0400
X-Authenticated: #14349625
Subject: Re: [RFC] sched.c : procfs tunables
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
In-Reply-To: <200604031459.43105.a1426z@gawab.com>
References: <200603311723.49049.a1426z@gawab.com>
	 <200604010044.09185.kernel@kolivas.org>
	 <200604031459.43105.a1426z@gawab.com>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 14:43:15 +0200
Message-Id: <1144068196.8083.30.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 14:59 +0300, Al Boldi wrote:
> Mike Galbraith wrote:
> > Nope, not the existing tunables anyway.  The full effect of even a tiny
> > scheduler knob tweak is hard to predict even if you've studied the code
> > carefully.  These knobs are just not generic enough to be exposed IMHO.
> 
> Are you implying that the code is built around these tunables rather than 
> using them?

I'm not implying anything, I'm merely stating my opinion: these knobs
have subtle effects which render them unsuitable for export.

	-Mike

