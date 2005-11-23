Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVKWUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVKWUex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVKWUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:34:52 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:18888 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932381AbVKWUeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:34:36 -0500
Date: Wed, 23 Nov 2005 21:23:10 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Greg KH <greg@kroah.com>
Cc: Marc Koschewski <marc@osknowledge.org>, Ian McDonald <imcdnzl@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-ID: <20051123202308.GC7446@stiffy.osknowledge.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123175045.GA6760@stiffy.osknowledge.org> <cbec11ac0511231133m63bec4ddi455fa769dd22906b@mail.gmail.com> <20051123195052.GA7446@stiffy.osknowledge.org> <20051123201238.GC29402@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123201238.GC29402@kroah.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <greg@kroah.com> [2005-11-23 12:12:38 -0800]:

> On Wed, Nov 23, 2005 at 08:50:54PM +0100, Marc Koschewski wrote:
> > * Ian McDonald <imcdnzl@gmail.com> [2005-11-24 08:33:36 +1300]:
> > 
> > > On 11/24/05, Marc Koschewski <marc@osknowledge.org> wrote:
> > > > Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
> > > > persists, moreover, some stuff's now really not gonna work anymore. I logged in
> > > > via gdm once and rebooted.
> > > >
> > > > Ragards,
> > > >         Marc
> > > >
> > > 
> > > Mouse problem is userspace. See bug 340202 on the Debian site.
> > > 
> > > Ian
> > 
> > ===
> > Package: udev
> > Version: 0.074-3
> > Severity: critical
> > Justification: breaks the whole system
> > 
> > 
> > When running Linux 2.6.15-rc1+, the new nested class devices used by the
> > input class prevent /dev/input/ from being created, rendering X
> > unusable.
> > ===
> > 
> > The problem over here exists _only_ in the -mm series, not plain 2.6.15-rc1
> > or 2.6.15-rc2. What's up then!? I use udev 0.74-3 as well. Mysterious...
> 
> It's a userspace issue as to how udev is creating the initial device
> nodes in Debian.
> 
> Odd that this only shows up in the -mm releases, as it should also show
> up for you in the -rc1 and -rc2 kernels.

I'm impressed ... :/
