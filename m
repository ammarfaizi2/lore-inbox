Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTE0X0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTE0X0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:26:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:24021 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264437AbTE0X0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:26:09 -0400
Date: Wed, 28 May 2003 00:40:51 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, John Stoffel <stoffel@lucent.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527234051.GA7174@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	John Stoffel <stoffel@lucent.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de> <4060000.1054072761@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4060000.1054072761@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:59:23PM -0700, Martin J. Bligh wrote:

 > > Given that 99% of users will be choosing option 1, it might be a
 > > good thing to have the remaining options only shown if a
 > > CONFIG_X86_SUBARCHS=y and have things default to option 1 if =n.
 > 
 > Please, not more layered config options! That just makes people who
 > want to enable the x440 or other alternative platform require fair
 > amounts of psychic power (maybe this can be fixed with a big fat help
 > message, but so can the current method).

With all due respect, 'screw x440 et al'. The fact remains that a
majority of users won't even know what an x440 _is_, let alone
need to configure for one.  If someone has actually ended up with
one of those, I'd like to think they at least have enough clue to
know what it is they've just spent their megabucks on.		

 > If you're going hide the other options away so much, then the default
 > should be the generic arch, IMHO.

That's precisely what I was saying.  I think we're in agreement,
in a roundabout 'same but different' sort of way. I think.

		Dave

