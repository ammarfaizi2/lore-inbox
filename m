Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbTCLQsN>; Wed, 12 Mar 2003 11:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbTCLQsN>; Wed, 12 Mar 2003 11:48:13 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:25012 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261771AbTCLQsN>; Wed, 12 Mar 2003 11:48:13 -0500
Date: Wed, 12 Mar 2003 16:56:11 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [patch 3/3] add Via Nehemiah ("xstore") rng support
Message-ID: <20030312175611.GB12251@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Ts'o <tytso@mit.edu>
References: <20030312125542.GA4284@suse.de> <Pine.LNX.4.44.0303120714030.13807-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303120714030.13807-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 07:16:37AM -0800, Linus Torvalds wrote:

 > >  > +#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
 > > Do we want to do this check only on VIA CPUs I wonder.
 > > As a vendor specific extension, I'd be inclined to do that.
 > 
 > No, the whole point of all the crud in arch/i386/kernel/cpu is to make 
 > those tests _once_ at bootup, and then the internal kernel "extended CPU 
 > feature set" has a unique feature-set that is independent of manufacturers 
 > and totally disjunct, so that we never need to care about manufacturers 
 > ever again.

Of course. Obviously a pre-caffeine email.

		Dave
