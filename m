Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTEVC4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 22:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTEVC4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 22:56:02 -0400
Received: from waste.org ([209.173.204.2]:37806 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262458AbTEVC4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 22:56:01 -0400
Date: Wed, 21 May 2003 22:08:57 -0500
From: oxymoron@waste.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       willy@debian.org
Subject: Re: must-fix list, v5
Message-ID: <20030522030857.GD23715@waste.org>
References: <20030521152255.4aa32fba.akpm@digeo.com> <3ECC21C9.5000708@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECC21C9.5000708@gmx.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 03:03:05AM +0200, Carl-Daniel Hailfinger wrote:
> Andrew Morton wrote:
> > Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/
> > 
> > For verson 6 I shall go through the "late features" list and prioritise
> > things.
> > 
> > Changes since v5:
> 
> > +o willy: random.c is completely lockfree, and not in a good way.  i had
> > +  some patches but nothing got seriously tested.
> 
> IIRC, Oliver Xymoron had some patches to clean up RNG support at the
> time of 2.5.39. Because things were in flux back then, he decided to
> postpone these patches until late in the 2.5 cycle.
> 
> Oliver?

Hope to respin some of the less theoretically motivated ones in the
next week, now that I've got a couple development machines. I'll look
over the locking stuff with Willy when he manages to recover his
latest from his dead laptop.

I'll probably repost the paranoid patches before long too.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
