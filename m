Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWAYWKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWAYWKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAYWKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:10:04 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15119 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751123AbWAYWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:10:04 -0500
Date: Wed, 25 Jan 2006 23:09:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Syed Ahemed <kingkhan@gmail.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch for CVE-2004-1334 ???
Message-ID: <20060125220954.GW7142@w.ods.org>
References: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com> <20060123191439.cfe5d61c.diegocg@gmail.com> <3d53b7120601250056s77e876b6l2ac6781b8a9c9f00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d53b7120601250056s77e876b6l2ac6781b8a9c9f00@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 02:26:51PM +0530, Syed Ahemed wrote:
> The simple reason we do not intend to use the latest version is we run
> some third party software which cant be front ported (pardon the slang
> ) to 2.4.29 and above.
> As for the changeset by  guninski , i wish to ask about a one point
> source of applying all the patches for 2.4.28 .I mean shouldn't all
> the kernel security patches ( atleast the ones that have become CVE's)
> be a part of kernel.org .Since there isn't any what is the reason ?

It's even more work for the person doing it. Maintaining the hotfixes
from 2.4.29 already takes me some time (not much more for 4 versions
than for one, what takes the most time is merging the patches, compiling
and releasing).

> I dont want to go to Gentoo for one patch , red hat for another
> ....and GOD knows how many sites .
> Torvalds is the GOD of open source , but am i asking for too much :-)

I can propose a deal to you. You send me a pointer to the patches that
need to be applied to 2.4.28 to make it as secure as 2.4.29, and I can
include 2.4.28 in my hotfix tree, so that you'll get regular updates
for free. I already have what is needed starting from 2.4.29, you just
have to point the 2.4.28-specific patches. It would time consuming for
me to review them all, but if someone like you has some interest in it,
it should be a win-win for both of us.

Simply send me the bkbits.net URLs, I should be able to do the rest.

Regards,
Willy

