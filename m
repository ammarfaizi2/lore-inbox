Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbTAZRAP>; Sun, 26 Jan 2003 12:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTAZRAP>; Sun, 26 Jan 2003 12:00:15 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7177 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266792AbTAZRAO>; Sun, 26 Jan 2003 12:00:14 -0500
Date: Sun, 26 Jan 2003 18:09:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
Message-ID: <20030126170927.GA14059@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <739810000.1043382396@aslan.scsiguy.com> <20030123.202727.102788332.davem@redhat.com> <756820000.1043384077@aslan.scsiguy.com> <20030123.205853.127871890.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123.205853.127871890.davem@redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, David S. Miller wrote:

> I'm glad that we've established that we both provide endless amounts
> of comedy for each other.
> 
> Look Justin, the fact remains that you get paid top dollar to maintain
> the Linux Adaptec driver.  If you can't be bothered to reliably
> integrate fixes that show up in Linus's and Marcelo's tree, then
> that's regretfully sad given your circumstances.
> 
> Now that is what makes me laugh!

David,

this is not how distributed development can work. The communication
clearly is broken here.

Regardless of whether Linus' tree is broken or no, ALWAYS Cc: the fixes
-- even if trivial -- to the driver maintainer.  It's as simple as that.

Same about complaints. If a tree breaks, complaining to the maintainer
in addition to Linus/Marcelo/Alan may yield a "Linus' merge is
incomplete, here's the missing bit" message from the maintainer.

It's all about communication. If maintainers drown in messages, they'll
tell this (Linus for example is notorious for dropping messages).

I don't mean to offend anyone, but what you expect looks like
clairvoyance to me, regardless of whether Justin gets paid or not, this
is simply not reasonable to expect.

Unless someone comes up with a "watchmydriver" script that checks the
ChangeSet figures of a set of files after every bk pull and complains if
Linus' tree complains unauthorized ChangeSets. I'm not sure if there is
an invariant tag that remains across getting bk patches applied or if
real diffs are needed. Larry or other BK experts might know more.

-- 
Matthias Andree
