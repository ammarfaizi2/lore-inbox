Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965768AbWKHOBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965768AbWKHOBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965767AbWKHOBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:01:49 -0500
Received: from mailhub4.stratus.com ([134.111.1.17]:14483 "EHLO
	mailhub4.stratus.com") by vger.kernel.org with ESMTP
	id S965768AbWKHOBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:01:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc4-mm2
Date: Wed, 8 Nov 2006 09:01:16 -0500
Message-ID: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A05C@EXNA.corp.stratus.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc4-mm2
Thread-Index: AccChXsNK+QP4hDuSAWWDr60Vsg3cwAuIPuA
From: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
To: <ajwade@alumni.uwaterloo.ca>, <andrew.j.wade@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-fbdev-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 08 Nov 2006 14:01:16.0866 (UTC) FILETIME=[5BF00220:01C7033E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew -

I messed around with trying to recreate the workaround for the 24bpp
Radeon stuff for chips that have the problem (like yours does) all
afternoon yesterday, but I never did get it to work. I can't spend any
more time on this right now (boss is after me!) but I will try to do
some more poking around later or next week. Do you think I should submit
a patch that at least enables 24bpp for the chip I have where it
definitely does work? I'm sure that is overly restrictive, but I don't
know which ones work and which are broken at this point. I tried going
to the ATI web site (we have an OEM agreement with them, so I can get
more data that way) but their documents are no better now that they are
part of AMD than they ever were, and I didn't find anything useful.
Grumble! Actually, as more people use linux and Xfree86, they may have
to do a bit better with the specs. One can hope!

If you get a chance before I do, you might look at what Xfree86 does -
they might have the workaround.

/Charlotte

PS - You have your reply-to email address set to
ajwade@alumni.uwaterloo.ca
which evidently is stale, 'cause replying to that bounces.

> -----Original Message-----
> From: Andrew Wade [mailto:andrew.j.wade@gmail.com]
> Sent: Tuesday, November 07, 2006 10:58 AM
> To: Richardson, Charlotte
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; Kimball Murray;
linux-
> fbdev-devel@lists.sourceforge.net
> Subject: Re: 2.6.19-rc4-mm2
> 
> Hello Charlotte,
> 
> > (Sorry, I don't know what timezone you're in, but I went home,
cooked
> > supper, ate supper, did two loads of laundry, slept for about seven
> > hours, ate breakfast, did another load of laundry, and voted, and
now
> > I'm back!)
> 
> I'm EST (GMT-5). But the hours I'm online are somewhat erratic.
> 
> ...
> > If I can't repro it with this chip, if you want to mess around with
it
> > on yours, here's what I think we had to do... I believe the trick
was
> > to use 16bpp mode as far as what mode you write to the chip, and
then
> > double all the x coordinate values for things like offset, width,
and
> > pitch. You would have to do that to the accelerated routines also.
> 
> I'd be happy to mess around with the driver, but I won't have much
> time to do so until tomorrow. I'll let you know if I find anything,
> and of course I'll be happy to test patches.
> 
> -ajw
