Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965375AbWAGA3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbWAGA3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWAGA3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:29:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4561 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932296AbWAGA3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:29:11 -0500
Date: Fri, 6 Jan 2006 19:28:33 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, davej@codemonkey.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Message-ID: <20060107002833.GB9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	davej@codemonkey.org.uk, airlied@linux.ie
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com> <20060105162714.6ad6d374.akpm@osdl.org> <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com> <20060105165946.1768f3d5.akpm@osdl.org> <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:25:22AM +0100, Jesper Juhl wrote:
 > On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
 > > Jesper Juhl <jesper.juhl@gmail.com> wrote:
 > >
 > > >  Reverted that one patch, then rebuild/reinstalled the kernel
 > > >  (with the same .config) and booted it - no change. It still locks up
 > > >  in the exact same spot.
 > > >  X starts & runs fine (sort of) since I can play around at the kdm
 > > >  login screen all I want, it's only once I actually login and KDE
 > > >  proper starts that it locks up.
 > >
 > > Oh bugger.  No serial console/netconsole or such?
 > >
 > > Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
 > > get an oops?
 > >
 > I switched to tty1 right after logging in, and after a few seconds
 > (corresponding pretty well with the time it takes to hit the same spot
 > where it crashed all previous times) I got a lot of nice crash info
 > scrolling by.
 > Actually a *lot* scrolled by, a rough guestimate says some 4-6 (maybe
 > more) screens scrolled by, and since the box locks up solid I couldn't
 > scroll up to get at the initial parts :(  So all I have for you is the
 > final block - hand copied from the screen using pen and paper
 > ...
 > It never makes it to the logs, and as mentioned previously I don't
 > have another machine to capture on via netconsole or serial, so if you
 > have any good ideas as to how to capture it all, then I'm all ears.

If only someone did a patch to pause the text output after the first oops..

Oh wait! Someone did!

		Dave

