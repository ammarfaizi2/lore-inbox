Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTE1F6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTE1F6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:58:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:15572 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264539AbTE1F63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:58:29 -0400
Date: Tue, 27 May 2003 23:11:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <13590000.1054102279@[10.10.2.4]>
In-Reply-To: <20030528033459.GR8978@holomorphy.com>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de> <4060000.1054072761@[10.10.2.4]> <20030528033459.GR8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point in the past, Dave Jones' attribution was stripped from:
>>> Given that 99% of users will be choosing option 1, it might be a
>>> good thing to have the remaining options only shown if a
>>> CONFIG_X86_SUBARCHS=y and have things default to option 1 if =n.
> 
> On Tue, May 27, 2003 at 02:59:23PM -0700, Martin J. Bligh wrote:
>> Please, not more layered config options! That just makes people who
>> want to enable the x440 or other alternative platform require fair
>> amounts of psychic power (maybe this can be fixed with a big fat help
>> message, but so can the current method).
>> If you're going hide the other options away so much, then the default
>> should be the generic arch, IMHO.
> 
> Or better yet, remove all the #ifdefs, finish generalizing the APIC
> code, and have nothing to configure at all. For 2.7 ...

For the "commerical" options like Summit and bigsmp, I think this is an
option for 2.5 even, given some more testing. And then the wierdo arches
can be better hidden ;-)

M.

