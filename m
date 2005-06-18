Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVFRWpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVFRWpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVFRWpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:45:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262192AbVFRWo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:44:58 -0400
Date: Sat, 18 Jun 2005 15:44:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-Id: <20050618154430.6c06d1cc.akpm@osdl.org>
In-Reply-To: <1119134359.7675.38.camel@localhost.localdomain>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<1119134359.7675.38.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> On Tue, 2005-06-07 at 04:29 -0700, Andrew Morton wrote:
> > +git-arm-smp.patch
> > 
> >  ARM git trees
> 
> The arm pxa255 based Zaurus won't resume from a suspend with the patches
> from the above tree applied. The suspend looks normal and gets at least
> as far as pxa_pm_enter(). After that, the device appears to be dead and
> needs a battery removal to reset. I'm unsure if it actually suspends and
> is failing to resume or is crashing in the latter suspend stages.
> 
> Is there some documentation on what the above patch is aiming to do
> anywhere?

Did you apply just that patch, or are you talking about the whole -mm lineup?

If the latter, please test with only git-arm-smp.patch.
