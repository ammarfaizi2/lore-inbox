Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWJCRlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWJCRlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWJCRlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:41:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030370AbWJCRla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:41:30 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: jt@hpl.hp.com
Cc: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061003172327.GA17443@bougret.hpl.hp.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
	 <200610022147.03748.rjw@sisk.pl>
	 <1159822831.11771.5.camel@localhost.localdomain>
	 <20061002212604.GA6520@thunk.org>
	 <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com>
	 <1159877574.2879.11.camel@localhost.localdomain>
	 <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org>
	 <20061003172327.GA17443@bougret.hpl.hp.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 13:40:33 -0400
Message-Id: <1159897233.5622.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 10:23 -0700, Jean Tourrilhes wrote:
> On Tue, Oct 03, 2006 at 09:38:45AM -0400, Theodore Tso wrote:
> > 
> > There is a fundamental question hiding here, which is whether or not
> > it is acceptable to break users who are running some large set of
> > mainline distro's, such as RHEL 4, SLES/SLED 10, Ubuntu Dapper,
> > et. al, but who want to upgrade to a newer 2.6 kernel?
> > 
> > Many users have moved to Ubuntu Dapper, or RHEL 4, or SLES/SLED 10
> > because they don't want to deal with a constantly changing/breaking
> > GNOME/X world, where packages are constantly being updated and
> > possibly breaking their desktop.
> 
> 	In the past, I personally tried to upgrade Red-Hat Workstation
> 4 with a pristine 2.6 kernel. This was far from trivial, as Red-Hat
> did compile their kernel with some weird options/patches, and
> userspace (libc) were expecting those.
> 	On the other hand, I've been personally running the latest
> 2.6.X kernels on Debian stable for as long as 2.6.X was
> available. And, things *do* break, in the past I had trouble with
> module tools, I can't run devfs or udev, Pcmcia is on the verge of
> breaking, etc...
> 
> 	In other words, running a bleeding edge kernel with a
> super-stable distro has never been for the casual user. And, I wonder
> what's the wisdom of it for the casual user, has he certainly can't
> use the advanced features of the new kernel unless he updates his
> userspace.
> 	My main box is Debian stable with a 2.4.X kernel. For that
> box, I don't see the point of going to the latest 2.6.X kernel, it
> would give me more trouble than benefits.
> 
> 	Just for kicks. Today, a new Slackware was released. And guess
> what, it has Wireless Tools 28 ;-)

I'm going to push wireless-tools-28 final for FC5-updates this week too.

Dan

> 
> 	Jean

