Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUEFBuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUEFBuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 21:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUEFBuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 21:50:32 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60903 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261252AbUEFBuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 21:50:08 -0400
Date: Wed, 5 May 2004 18:50:03 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ian Kumlien <pomac@vapor.com>
Cc: ross@datscreative.com.au, linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040506015003.GA2085@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Ian Kumlien <pomac@vapor.com>, ross@datscreative.com.au,
	linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405052124.55515.ross@datscreative.com.au> <1083759539.2797.24.camel@big> <200405052252.29359.ross@datscreative.com.au> <1083762481.2797.49.camel@big>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083762481.2797.49.camel@big>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 03:08:01PM +0200, Ian Kumlien wrote:
> On Wed, 2004-05-05 at 14:52, Ross Dickson wrote:
> > On Wednesday 05 May 2004 22:18, Ian Kumlien wrote:
> > > On Wed, 2004-05-05 at 13:24, Ross Dickson wrote:
> > > <snip>
> > > > They can't see through their Windows.??!@@#$$%%&*&
> > > > 
> > > > ML1-0505-19 Re: Cause of lockups with KM-18G Pro is incorrect pci reg values in bios -please update bios
> > > > 
> > > > From: 
> > > > "dr.pro" <dr.pro@albatron.com.tw>
> > > > 
> > > > To: 
> > > > <ross@datscreative.com.au>
> > > > 
> > > > Date: 
> > > > Today 17:38:08
> > > > 
> > > >   Dear Ross,
> > > > 
> > > >   Thank you very much for contacting Albatron technical support.
> > > > 
> > > >   KM18G Pro has been proved under Windows 98SE/ME/2000/XP but Linux, so > > > > you may encounter problems with it under Linux. We suggest you use 
> > > > Windows 98SE/ME/2000/XP for the stable performance. Sorry for the 
> > > > inconvenience and please kindly understand it.
> > > > 
> > > >   Please let us know if you have any question.

!!!

> > > 
> > > Please kindly understand it? I wouldn't... I'm about to bash asus, so...
> > > This information gets me in the moood to do some real bashing =)
> > > 
> > > Btw, does windows do a C1 disconnect? And if so how often?
> > 
> > I think it does as temps are lower then linux without disconnect.
> > Here are some temperatures from my machine read from the bios on reboot.
> > I gave it minimal activity for the minutes prior to reboot.
> > 
> >  Win98, 47C
> >  XPHome, 42C
> >  Patched Linux 2.4.24 (1000Hz), 40C
> >  Linux 2.6.3-rc1-mm1, 53C  with no disconnect

Patched AN35N Bios w/ Linux, C1 Disconnect on:
idle system, 39-41 C
heavy activity, 50-51 C

Though I have since added two additional fans to my system.  When it is under
heavy activity, it will obviously go up to 51 C.  When it is finished and 
becomes idle again, then the CPU temp will quickly go back down to 39-41 C
because the additional fans remove the heat quite effectively.

> >  
> > I think the disconnect happens for less time percentage. With slower
> > ticks one might assume less often than linux. 
> > -Ross
> 
> Which means that the problem isn't as likely to occur under Windows,
> which also explains why mb-manuf ppl are lazy =P.
>  


Ross, you should reply to them and say the problem affects windows as well.  I
can't imagine it immune.  Although, windows is not that aggressive, I think 
it's still affected.  It doesn't matter that people don't think windows has
this hang.  It still has it.  It doesn't matter that they can't reproduce it 
under what they think are normal circumstances.  It _still_ has it.

Actually it isn't a OS problem, it's a BIOS problem.  It has nothing to do with
the OS.  It's the quality of their boards we're talking about.  If only they
get that...

Jesse


