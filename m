Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030632AbWJCWcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbWJCWcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWJCWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:32:06 -0400
Received: from thunk.org ([69.25.196.29]:37300 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030618AbWJCWcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:32:03 -0400
Date: Tue, 3 Oct 2006 18:30:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Dan Williams <dcbw@redhat.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003223029.GA26351@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jean Tourrilhes <jt@hpl.hp.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Dan Williams <dcbw@redhat.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	hostap@shmoo.com, linux-kernel@vger.kernel.org
References: <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org> <20061003172327.GA17443@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003172327.GA17443@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 10:23:27AM -0700, Jean Tourrilhes wrote:
> 	In the past, I personally tried to upgrade Red-Hat Workstation
> 4 with a pristine 2.6 kernel. This was far from trivial, as Red-Hat
> did compile their kernel with some weird options/patches, and
> userspace (libc) were expecting those.

I (well, me and my team) am supporting a customer using a RHEL 4
userspace and a 2.6.16 kernel with Ingo's real-time patches.  We just
used Red Hat config file as the basis, and it wasn't that hard.  There
were some initrd breakages, which I've complained about in the past,
but the goal is that this sort of thing is supposed to work!  (And for
the most part, it does).

> 	On the other hand, I've been personally running the latest
> 2.6.X kernels on Debian stable for as long as 2.6.X was
> available. And, things *do* break, in the past I had trouble with
> module tools, I can't run devfs or udev, Pcmcia is on the verge of
> breaking, etc...

I'm currently using the latest 2.6 kernel with Ubuntu 6.06 (their
stable release), and to date, I haven't had any problems.  

Of course, that may be about to change, given that Ubuntu is shipping
with wireless-tools version "27+28pre13-1ub", which I assume is a
version between 27 and 28.  Do you know off-hand whether this is is
WE-21 capable?

						- Ted
