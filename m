Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVDARdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVDARdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVDARat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:30:49 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:17888 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262829AbVDAR30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:29:26 -0500
Date: Fri, 1 Apr 2005 19:29:15 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: dtor_core@ameritech.net
Cc: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Touchpad does not work anymore
Message-ID: <20050401172915.GO10278@ens-lyon.fr>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com> <20050331165007.GA29674@pern.dea.icai.upco.es> <200503311309.50165.dtor_core@ameritech.net> <40f323d0050401081423650536@mail.gmail.com> <d120d5000504010828152031a@mail.gmail.com> <20050401164321.GN10278@ens-lyon.fr> <d120d5000504010900142bed75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000504010900142bed75@mail.gmail.com>
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 12:00:42PM -0500, Dmitry Torokhov wrote:
> On Apr 1, 2005 11:43 AM, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> > On Fri, Apr 01, 2005 at 11:28:05AM -0500, Dmitry Torokhov wrote:
> > > On Apr 1, 2005 11:14 AM, Benoit Boissinot <bboissin@gmail.com> wrote:
> > > > On Mar 31, 2005 8:09 PM, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > > > It works, too. Which one is the best one?
> > > > > >
> > > > >
> > > > > Both of them are needed as they address two different problems.
> > > > >
> > > > I tried to boot with the 2 patches applied (and the patch which solves
> > > > noresume) and now touchpad/touchpoint no longer works (with this
> > > > kernel or with an older kernel).
> > > >
> > >
> > > Could you be more explicit - it is not recognized at all or it is
> > > recognized but mouse pointer does not move or something else? dmesg
> > > also might be interesting.
> > >
> > It is recognized in dmesg (same message as before), but the mouse
> > pointer does not move (a `cat /dev/input/mice` doesn't do anything).
> > 
> 
> Should work... The patches come into play only when
> suspending/resuming. So you are saying even with an old, unpatched
> kernel ALS stopped working, right?
>
I did a suspend/resume with the patches applied. And yes it doesn't work
with an old unpatched kernel.
Detected in dmesg, but no movement.

> Hmm, that USB mouse - was it there before? I wonder if "usb-handoff"
> on the kernel comman line will help.
>
I plugged it after i saw the touchpad didn't worked anymore (and i test
if the touchpad works without the mouse plugged in).

> -- 
> Dmitry

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
