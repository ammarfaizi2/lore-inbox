Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSFDS2x>; Tue, 4 Jun 2002 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSFDS2w>; Tue, 4 Jun 2002 14:28:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10252 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315762AbSFDS2v>; Tue, 4 Jun 2002 14:28:51 -0400
Date: Tue, 4 Jun 2002 14:24:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9, still USB freeze
In-Reply-To: <20020529145010.21d01e80.skraw@ithnet.com>
Message-ID: <Pine.LNX.3.96.1020604142039.5024A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Stephan von Krawczynski wrote:

> as noted for pre8, pre9 freezes still, when connecting a sandisk SDDR-05 to USB
> (only device attached), and trying to mount some compact-flash. Or, as an
> alternative test, even with no compact flash inserted, when starting up
> xcdroast. Both completely freezes the machine.
> 
> pre6 was ok.

I have been seeing lockups on the same kernels with compact flash and a
dual PCMCIA adaptor in an SMP machine. Prior to pre7 the kernel PCMCIA
would take forever (longer than overnight) to access the device, while
disabling the kernel PCMCIA and using the separate modules works.

The kernel stuff works fine in a uni laptop, so hard to tell where the
problem lies, other than I think you mentioned being SMP also?

Random semi-relevant facts, hopefully useful to someone.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

