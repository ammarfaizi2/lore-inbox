Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWDIQqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDIQqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 12:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWDIQqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 12:46:03 -0400
Received: from [212.33.180.21] ([212.33.180.21]:24324 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750812AbWDIQqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 12:46:02 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 9 Apr 2006 19:44:28 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200604091944.28954.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Sun, Apr 09, 2006 at 01:39:38PM +0200, Mike Galbraith wrote:
> > Ok, unusable may be overstated.  Nonetheless, that bit of code causes
> > serious problems.  It makes my little PIII/500 test box trying to fill
> > one 100Mbit local network unusable.  That is not overstated.
>
> If you try to make a PIII/500 fill 100mbit of TCP/IP using lots of
> different processes, that IS a corner load.
>
> I'm sure you can fix this (rare) workload but are you very sure you are
> not killing off performance for other situations?

This really has nothing to do w/ workload but rather w/ multi-user processing 
/tasking /threading.  And the mere fact that the 2.6 kernel prefers 
kernel-threads should imply an overall performance increase (think pdflush).

The reason why not many have noticed this scheduler problem(s) is because 
most hackers nowadays work w/ the latest fastest hw available which does not 
allow them to see these problems (think Windows, where most problems are 
resolved by buying the latest hw).

Real Hackers never miss out on making their work run on the smallest common 
denominator (think i386dx :).

Thanks!

--
Al

