Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVHPRRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVHPRRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVHPRRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:17:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030255AbVHPRRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:17:09 -0400
Date: Tue, 16 Aug 2005 10:15:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       gerg@uclinux.org, jdike@karaya.com, sammy@sammy.net,
       lethal@linux-sh.org, wli@holomorphy.com, davem@davemloft.net,
       matthew@wil.cx, geert@linux-m68k.org, paulus@samba.org,
       davej@codemonkey.org.uk, tony.luck@intel.com, dev-etrax@axis.com,
       rpurdie@rpsys.net, spyro@f2s.com, Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Convert sigaction to act like other unices
In-Reply-To: <1124211863.5764.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508161014400.3553@g5.osdl.org>
References: <1123900802.5296.88.camel@localhost.localdomain> 
 <20050813123956.GN22901@wotan.suse.de>  <1123941614.5296.112.camel@localhost.localdomain>
  <20050813212924.GQ22901@wotan.suse.de>  <9a874849050814052035ad2838@mail.gmail.com>
 <1124211863.5764.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Aug 2005, Steven Rostedt wrote:
> 
> b) add the patch (in -mm or early 14 or later), see if any applications
> break, but we will finally match the man pages and etc.

We'll definitely test the patch. I doubt it breaks anything, and it's the 
right thing to do, but yes, we'll try it out very early in the 2.6.14 
cycle. Somebody make sure to send me the patch after I release 2.6.13 so 
that I don't forget.

		Linus
