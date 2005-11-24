Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVKXJkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVKXJkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVKXJkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:40:09 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:4044 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751341AbVKXJkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:40:07 -0500
Date: Thu, 24 Nov 2005 10:40:22 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Frank Sorenson <frank@tuxrocks.com>, Andrew Morton <akpm@osdl.org>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org
Subject: Re: Mouse issues in -mm
Message-ID: <20051124094019.GA6788@stiffy.osknowledge.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123113854.07fca702.akpm@osdl.org> <4385202E.70404@tuxrocks.com> <200511232226.44459.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232226.44459.dtor_core@ameritech.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-23 22:26:43 -0500]:

> On Wednesday 23 November 2005 21:06, Frank Sorenson wrote:
> > Andrew Morton wrote:
> > > Marc Koschewski <marc@osknowledge.org> wrote:
> > >>Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
> > >>persists,
> > >
> > > You'l probably need to re-report the mouse problem if the previous report
> > > didn't get any action.
> > 
> > I'm not certain whether this is the same 'mouse problem', but I'll
> > report the mouse problems I've been seeing.  In the past several -mm
> > kernels, my touchpad has initially worked at boot, but 'tapping' has
> > stopped working at some point later (with no obvious kernel messages).
> > 
> > I've experienced this problem at least with 2.6.15-rc1-mm2 and
> > 2.6.15-rc2-mm1, and reverting
> > input-attempt-to-re-synchronize-mouse-every-5-seconds.patch gives a
> > kernel without the touchpad problems.
> >
> 
> What kind of touchpad do you have? Could you post your
> /pros/bus/input/devices please?

Mine is like this:

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/class/input/input0
H: Handlers=kbd event0
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/class/input/input1
H: Handlers=kbd event1
B: EV=40001
B: SND=6

I: Bus=0011 Vendor=0002 Product=0005 Version=0000
N: Name="ImPS/2 Generic Wheel Mouse"
P: Phys=isa0060/serio1/input0
S: Sysfs=/class/input/input2
H: Handlers=event2 mouse0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

I don't know why my touchpad is not listed. I have one and it perfectly
works with X (same pointer as the mouse which is a Microsoft USB Wheel Mouse'
attached to PS/2 using an appropriate adapter.

Marc
