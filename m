Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbRFGVrC>; Thu, 7 Jun 2001 17:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263309AbRFGVqm>; Thu, 7 Jun 2001 17:46:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63363 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263288AbRFGVqj>;
	Thu, 7 Jun 2001 17:46:39 -0400
Date: Thu, 7 Jun 2001 23:46:20 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106072146.XAA217951.aeb@vlet.cwi.nl>
To: ramsy@linux.or.jp, torvalds@transmeta.com
Subject: Re: Configure.help i18n system
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if the Configure.help text should not possibly be even _more_
> distributed than just splitting it up into different files. It might very
> well be acceptable to actually distribute it over the net (and have just
> a mapping of config options into www-addresses or something).

I think this is a bad idea.

(i) The kernel has high visibility, and work on the kernel
[even if only on the Documentation subdirectory] has high "prestige".
As a consequence, parts of the kernel tree are kept much better
up-to-date than documentation found elsewhere.

(I have been trying for years to find people willing to do something
to the very outdated ioctl_list.2 or proc.5 or bootparam.7.)

When distributed, very quickly Configure.help would be outdated,
and of very uneven format and quality.

(ii) So far, building a kernel involved getting a single tarball.
If the help for over a thousand configuration options is found
a hundred different places on the net, of which five are currently
unreachable, things get really cumbersome.

The current system is not so bad.

Andries

