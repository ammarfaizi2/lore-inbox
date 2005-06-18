Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVFRW5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVFRW5t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVFRW5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:57:49 -0400
Received: from tim.rpsys.net ([194.106.48.114]:31659 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262195AbVFRW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:57:47 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050618154430.6c06d1cc.akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	 <1119134359.7675.38.camel@localhost.localdomain>
	 <20050618154430.6c06d1cc.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Jun 2005 23:57:41 +0100
Message-Id: <1119135461.7675.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-18 at 15:44 -0700, Andrew Morton wrote:
> Richard Purdie <rpurdie@rpsys.net> wrote:
> >
> > On Tue, 2005-06-07 at 04:29 -0700, Andrew Morton wrote:
> > > +git-arm-smp.patch
> > > 
> > >  ARM git trees
> > 
> > The arm pxa255 based Zaurus won't resume from a suspend with the patches
> > from the above tree applied. The suspend looks normal and gets at least
> > as far as pxa_pm_enter(). After that, the device appears to be dead and
> > needs a battery removal to reset. I'm unsure if it actually suspends and
> > is failing to resume or is crashing in the latter suspend stages.
> > 
> > Is there some documentation on what the above patch is aiming to do
> > anywhere?
> 
> Did you apply just that patch, or are you talking about the whole -mm lineup?
> 
> If the latter, please test with only git-arm-smp.patch.

Sorry, I wasn't clear. I had problems with the -mm lineup and tracked it
down to the above patch. With the above patch removed, -mm works fine. 

(I know there's a number of changes to the arm pxa suspend/resume code
in git-arm.patch but they're definitely not causing the problem.)

Richard

