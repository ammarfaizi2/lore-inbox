Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWJCR2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWJCR2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWJCR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:28:12 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:41198 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1030291AbWJCR2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:28:08 -0400
Date: Tue, 3 Oct 2006 10:23:27 -0700
To: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Dan Williams <dcbw@redhat.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003172327.GA17443@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003133845.GG2930@thunk.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:38:45AM -0400, Theodore Tso wrote:
> 
> There is a fundamental question hiding here, which is whether or not
> it is acceptable to break users who are running some large set of
> mainline distro's, such as RHEL 4, SLES/SLED 10, Ubuntu Dapper,
> et. al, but who want to upgrade to a newer 2.6 kernel?
> 
> Many users have moved to Ubuntu Dapper, or RHEL 4, or SLES/SLED 10
> because they don't want to deal with a constantly changing/breaking
> GNOME/X world, where packages are constantly being updated and
> possibly breaking their desktop.

	In the past, I personally tried to upgrade Red-Hat Workstation
4 with a pristine 2.6 kernel. This was far from trivial, as Red-Hat
did compile their kernel with some weird options/patches, and
userspace (libc) were expecting those.
	On the other hand, I've been personally running the latest
2.6.X kernels on Debian stable for as long as 2.6.X was
available. And, things *do* break, in the past I had trouble with
module tools, I can't run devfs or udev, Pcmcia is on the verge of
breaking, etc...

	In other words, running a bleeding edge kernel with a
super-stable distro has never been for the casual user. And, I wonder
what's the wisdom of it for the casual user, has he certainly can't
use the advanced features of the new kernel unless he updates his
userspace.
	My main box is Debian stable with a 2.4.X kernel. For that
box, I don't see the point of going to the latest 2.6.X kernel, it
would give me more trouble than benefits.

	Just for kicks. Today, a new Slackware was released. And guess
what, it has Wireless Tools 28 ;-)

	Jean
