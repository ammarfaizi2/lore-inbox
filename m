Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVCNPGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVCNPGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVCNPGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:06:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:42901 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261530AbVCNPFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:05:53 -0500
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for
	openfirmware	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <0409878c894cf868678d8e5226e20c42@kernel.crashing.org>
References: <20050301211824.GC16465@locomotive.unixthugs.org>
	 <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com>
	 <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com>
	 <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org>
	 <1110808986.5863.2.camel@gaston>
	 <0409878c894cf868678d8e5226e20c42@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 02:04:21 +1100
Message-Id: <1110812661.5863.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well, we have an unmaintained spec on one side that can't even be
> > ordered from IEEE anymore and actual imlementations that work today,
> > what do you chose ? ;)
> 
> I choose the spec.  If an implementation is not conformant to the spec,
> it doesn't "work".
> 
> Not to say that Linux doesn't have to work around bugs in actual
> implementations, of course.  And there's a lot of those.  Too bad ;-)

Yah, well.. ok, let's say we have a spec... and an implementation that
represents about 90% of the machines concerned. Those 90% have the
"bug"... what do you chose ? :) 

The separator in "compatible", afaik, is \0, not space btw.

On possibiliy would be to have the kernel replace spaces with
underscores for the sake of matching. That would make life easier for
everybody.

Ben.


