Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVHLAMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVHLAMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVHLAMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 20:12:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932282AbVHLAMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 20:12:22 -0400
Date: Thu, 11 Aug 2005 17:11:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Tim Yamin <plasmaroo@gentoo.org>, Tavis Ormandy <taviso@gentoo.org>
Subject: Re: [patch 4/8] [PATCH] Update in-kernel zlib routines
Message-ID: <20050812001124.GG7762@shell0.pdx.osdl.net>
References: <20050811225445.404816000@localhost.localdomain> <20050811225626.233013000@localhost.localdomain> <m3acjodnwb.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acjodnwb.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Osterlund (petero2@telia.com) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> > a) http://sources.redhat.com/ml/bug-gnu-utils/1999-06/msg00183.html
> 
> Why does this 6 year old bug have to be fixed in the 2.6.12 stable
> series? Doesn't the patch violate this stable series rule?
> 
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing.)
> 
> Maybe the motivation was just missing from the patch description?

These can manifest as possible overflow (1st one, given CAN-2005-2458),
or NULL deref (2nd one given CAN-2005-2459), which could have possible
security consequences.

thanks,
-chris
