Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWJHXfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWJHXfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWJHXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:35:51 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:28128 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932111AbWJHXfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:35:50 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160348036.5686.155.camel@localhost.localdomain>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160323127.5686.37.camel@localhost.localdomain>
	 <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326363.5686.48.camel@localhost.localdomain>
	 <1160327879.3693.97.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160334205.5686.72.camel@localhost.localdomain>
	 <1160339986.3693.135.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160340722.5686.85.camel@localhost.localdomain>
	 <1160342112.3693.146.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160342424.5686.102.camel@localhost.localdomain>
	 <1160343099.3693.153.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160343506.5686.113.camel@localhost.localdomain>
	 <1160345593.3693.180.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160348036.5686.155.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 16:35:43 -0700
Message-Id: <1160350543.3693.238.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 00:53 +0200, Thomas Gleixner wrote:
> On Sun, 2006-10-08 at 15:13 -0700, Daniel Walker wrote:
> > On Sun, 2006-10-08 at 23:38 +0200, Thomas Gleixner wrote:
> > 
> > > 
> > > I don't see that behaviour on my machines and nobody complains about
> > > that. I don't care about stale comments. Point me to a bug report
> > > instead of your perception of what's optimal and not.
> > 
> > Let both do this. Lets discuss empirical behavior. Otherwise we aren't
> > making any progress. 
> 
> Go, grep the LKML archives and let those who had problems test your
> modifications. Come back when they confirm that it does not change
> anything.

This is why I want this to go into -mm .. To flush out the corner cases
that it's impossible for me to find on my own.

> You want to change behaviour of the current code, so it's your job to
> verify that it does not break anything.

I have, within my ability to do so.

> I have been there and done that with the ARM interrupt code
> http://www.linutronix.de/index.php?page=testing
> 
> I know what I'm talking about.

I think you know what your talking about, and I respect your opinion.. I
think you have some points, that I will follow up on. However most of
what your saying comes off to me like, "Reverse _all_ your changes!" ,
"Makes this patch set go away for 2 months", and I don't understand
where that is coming from.

Daniel

