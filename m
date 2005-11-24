Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbVKXC3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbVKXC3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbVKXC3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:29:07 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:52215 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1030544AbVKXC3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:29:06 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Wed, 23 Nov 2005 21:29:35 -0500
User-Agent: KMail/1.8.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       340202@bugs.debian.org
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511212243.50707.dtor_core@ameritech.net> <20051123195700.GB7446@stiffy.osknowledge.org>
In-Reply-To: <20051123195700.GB7446@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232129.35796.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 14:57, Marc Koschewski wrote:
> * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-21 22:43:50 -0500]:
> 
> > On Sunday 20 November 2005 12:14, Marc Koschewski wrote:
> > > * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-18 22:07:19 -0500]:
> > > 
> > > > On Friday 18 November 2005 13:29, Marc Koschewski wrote:
> > > > > Nov 18 12:58:37 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
> > > > > 
> > > > > SOME STUFF MISSING? HUH?
> > > > > 
> > > > > Nov 18 13:03:14 stiffy kernel: psmouse.c: resync failed, issuing reconnect request
> > > > > 
> > > > 
> > > > Hm, this worries me a bit... Could you please try appying the patch
> > > > below to plain 2.6.15-rc1 and see if mouse starts misbehaving again?
> > > 
> > > Dmitry,
> > > 
> > > I applied the 5 patches to a plain 2.6.15-rc1. The mouse was well as if it was
> > > in an unpatched kernel. The problem just occured in 2.6.15-rc1-mmX.
> > > Plain 2.6.15-rc1 was fine before as well. So: actually no change.
> > > 
> > > Need any more info?
> > >
> > 
> > Marc,
> > 
> > Thank you for testing the patch. It proves that your mouse troubles
> > were not caused by the patch I made so I am very happy. "No change"
> > is the result I wanted to hear ;)
> > 
> 
> Dmitry,
> 
> there's a bug report filed against Debian's udev. You can read it here:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=340202
> 
> The bug report, however, states that the problem is caused by udev under
> all variants of kernel 2.6.15. I'm writing this mail while running
> 2.6.15-rc1 and the mouse definitely works. Do you have any other hint?
> Seems to me like the bug report is only half the truth... 

Marc,

Are you, by some slim chance, manually loading mousedev ( via /etc/modules) or
an init script?  If so your mouse will work.

Ed Tomlinson 
