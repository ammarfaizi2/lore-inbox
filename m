Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRLDRgQ>; Tue, 4 Dec 2001 12:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRLDRei>; Tue, 4 Dec 2001 12:34:38 -0500
Received: from duracef.shout.net ([204.253.184.12]:3347 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S278932AbRLDRTA>; Tue, 4 Dec 2001 12:19:00 -0500
Date: Tue, 4 Dec 2001 11:18:38 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200112041718.LAA21719@duracef.shout.net>
To: esr@thyrsus.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose a polite title for me would be "maintainer emiritus"
of make config, make menuconfig, and make xconfig.

I'm in favor of abandoning the current tools because:

  It's 3x maintenance to have 3 parsers for the same language.

  It's difficult to do good syntax checking in scripts/Configure and
  menuconfig.

  menuconfig in particular is too ugly to live.

  A company which considers Linux its #1 enemy may own the copyright to
  "scripts/Configure".  I don't know what kind of marketing or legal
  play they could make, but it would surely be hostile to Linux.

I'm in favor of CML2 in particular because:

  ESR has designed a clean theory, which the configuration process really
  needs after ten years of ad hoc extensions.

  ESR has done a lot of grunt work to turn a particular idea into a
  viable implementation.  It's hard to get that work done.

As far as the Python issue goes, I believe that the kernel documentation
just needs to state clearly what tools (and what versions) are needed
to build a kernel.  If other people prefer a C implementation, then
CML2 (the language) is amenable to a C implementation, so they can
write one.

As far as CML2 versus an mconfig-based solution, I am tilted towards CML2,
as it is simply a better language.  I would be happy with either choice
if Linus made one of those choices.  I would be unhappy if 2.6/3.0
continued to ship with Configure/menuconfig/xconfig.

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"
