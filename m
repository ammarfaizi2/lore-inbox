Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVFRGgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVFRGgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVFRGgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 02:36:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:26001 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262100AbVFRGgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 02:36:07 -0400
Subject: Re: [PATCH] Dynamic tick for x86 version 050610-1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hugang@soulinfo.com
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <20050618033419.GA6476@hugang.soulinfo.com>
References: <20050602013641.GL21597@atomide.com>
	 <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com>
	 <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com>
	 <20050610091515.GH4173@elf.ucw.cz> <20050610151707.GB7858@atomide.com>
	 <20050610221501.GB7575@atomide.com>
	 <20050618033419.GA6476@hugang.soulinfo.com>
Content-Type: text/plain
Date: Sat, 18 Jun 2005 16:30:32 +1000
Message-Id: <1119076233.18247.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm try to port it powerpc, Here is a patch.
> 
>  Port Dynamic Tick Timer to new platform is easy. :)
>   1) Find the reprogram timer interface.
>   2) do a hook in the idle function.
> 
> That worked on my PowerBookG4 12'.

Did you get a measurable gain on power consumption ?

Last time I toyed with this, I didn't.

Ben.


