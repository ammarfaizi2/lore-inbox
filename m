Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271900AbTHKFu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271924AbTHKFu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:50:27 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:4344 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S271900AbTHKFuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:50:24 -0400
Subject: Re: [PATCH]O14int
From: Martin Schlemmer <azarah@gentoo.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff White <cliffw@osdl.org>
In-Reply-To: <200308091904.19222.kernel@kolivas.org>
References: <200308090149.25688.kernel@kolivas.org>
	 <200308091904.19222.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060580691.13254.7.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 07:44:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 11:04, Con Kolivas wrote:
> On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
> > More duck tape interactivity tweaks
> 
> s/duck/duct
> 
> > Wli pointed out an error in the nanosecond to jiffy conversion which may
> > have been causing too easy to migrate tasks on smp (? performance change).
> 
> Looks like I broke SMP build with this. Will fix soon; don't bother trying 
> this on SMP yet.
> 

Not to be nasty or such, but all these patches have taken
a very responsive HT box to one that have issues with multiple
make -j10's running and random jerkyness.

I am not so sure I for one want changes to the scheduler for
SMP (not UP interactivity ones anyhow).


Cheers,

-- 
Martin Schlemmer


