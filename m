Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbTCLGI5>; Wed, 12 Mar 2003 01:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbTCLGI5>; Wed, 12 Mar 2003 01:08:57 -0500
Received: from almesberger.net ([63.105.73.239]:12560 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S263062AbTCLGI4>; Wed, 12 Mar 2003 01:08:56 -0500
Date: Wed, 12 Mar 2003 03:19:31 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Zack Brown <zbrown@tumblerings.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030312031930.X2791@almesberger.net>
References: <20030311184043.GA24925@renegade> <200303120347.h2C3loEG002703@eeyore.valparaiso.cl> <20030312052225.GO4716@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312052225.GO4716@renegade>; from zbrown@tumblerings.org on Tue, Mar 11, 2003 at 09:22:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown wrote:
> Maybe the system should simply ignore the whole concept of time as occurring
> in discrete ticks, and just measure time as the relative history of
> changesets.

Real time is still useful, if only as a hint to users. E.g.
assume that you have dependencies the SCM doesn't know about.

Example: somebody posts on linux-kernel a one-line fix for a
remote root exploit. You'll instantly get dozens of people who
will apply that one to their local views, without waiting or
making a common unique change set.

Some of those view may have branched from a long time ago, and
not have touched any common change set for months. So the
partial order of applied change sets tells you very little.

Naturally, such one-line fixes will be slightly different, and
eventually, some of them will merge ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
