Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbSKLJ5x>; Tue, 12 Nov 2002 04:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266404AbSKLJ5x>; Tue, 12 Nov 2002 04:57:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32965 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266377AbSKLJ5w>;
	Tue, 12 Nov 2002 04:57:52 -0500
Date: Tue, 12 Nov 2002 05:04:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs
In-Reply-To: <1037094221.16831.21.camel@bip>
Message-ID: <Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 Nov 2002, Xavier Bestel wrote:

> I'm wondering if a totally userspace solution could replace devs ?
> Something using hotplug + sysfs and creating directories/nodes as they
> appear on the system. This way, the policy (how do I name what) could be
> moved out of the kernel.

	Guys, may I remind you that Oct 31 had been more than a week ago?
Devfs *is* a race-ridden pile of crap, but we are in a goddamn feature
freeze, so let's get real.

	Interfaces can and should be cleaned up.  Ditto for semantics of
registering/unregistering - that allows to make glue in drivers more
straightforward.  Majestic flamewars about removing the thing completely/
moving it to userland/etc. are exercises in masturbation by that point.

	Again, WE ARE IN FEATURE FREEZE.

	Now, does somebody have technical comments on the proposed changes?

