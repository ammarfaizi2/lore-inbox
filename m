Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVGVCKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVGVCKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 22:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVGVCKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 22:10:48 -0400
Received: from king.bitgnome.net ([70.84.111.244]:35759 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S261994AbVGVCKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 22:10:47 -0400
Date: Thu, 21 Jul 2005 21:10:46 -0500
From: Mark Nipper <nipsy@bitgnome.net>
To: Martin =?utf-8?Q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel version
Message-ID: <20050722021046.GB21727@king.bitgnome.net>
References: <42E04D11.20005@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E04D11.20005@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have a different idea along these lines but not using
bugzilla.  A nice system for tracking usage of certain components
might be made by having people register using a certain e-mail
address and then submitting their .config as they try out new
versions of kernels.

	The idea of course is that people will generally only
have compiled their own custom kernels with the drivers and
components they tend to use most.  It might be enough to ask
people who use this system to only submit mostly customized
configurations as opposed to distribution style kernel
configurations where almost everything is compiled as a module.

	Anyway, the end result being that kernel developers could
ultimately refer to this system and see as they change things
whether a lot of people are hitting the components in the kernel
which might have been affected by their changes.  If even one
hundred people report using some specific subsystem which has
recently undergone significant change without any reports of
problems, then the developer can rest somewhat more easily
knowing their changes were probably made without incident.

	Just an idea.  It might require some minimum
recommendations to users willing to participate.  I know for
example that I statically compile all four I/O schedulers in all
my kernels currently even though I always let the kernel select
whichever is the default and never change it myself.  Obviously
it would make more sense for me to axe those schedulers which are
not absolutely necessary to make whatever statistics being
gathered on my particular configuration more useful to a
developer checking to see which schedulers are being used and to
what extent.

-- 
Mark Nipper                                                e-contacts:
4475 Carter Creek Parkway                           nipsy@bitgnome.net
Apartment 724                               http://nipsy.bitgnome.net/
Bryan, Texas, 77802-4481           AIM/Yahoo: texasnipsy ICQ: 66971617
(979)575-3193                                      MSN: nipsy@tamu.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
This sentence no verb.
----end random quote of the moment----
