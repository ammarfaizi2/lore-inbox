Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286372AbRL0ROg>; Thu, 27 Dec 2001 12:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286370AbRL0RO0>; Thu, 27 Dec 2001 12:14:26 -0500
Received: from msp-150.man.olsztyn.pl ([213.184.31.150]:896 "EHLO
	msp-150.man.olsztyn.pl") by vger.kernel.org with ESMTP
	id <S286372AbRL0ROU>; Thu, 27 Dec 2001 12:14:20 -0500
Date: Thu, 27 Dec 2001 18:13:21 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: linux-kernel@vger.kernel.org
Subject: SOLVED Re: 2.2/2.4 Kernel oops/hang right after Calibrating delay loop...
Message-ID: <20011227171321.GA1278@msp-150.man.olsztyn.pl>
In-Reply-To: <20011227122505.GA5445@msp-150.man.olsztyn.pl> <E16Jdef-00062O-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Jdef-00062O-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 27 December 2001, Alan Cox wrote:
> > So, if anyone has _any_ idea where to look for the cause of this problem,
> > we'd really appreciate it.
> > Could this be a hardware problem?
> 
> Almost certainly. Check the heatsink/fan on the CPU, the voltages.

That was ok, but ...

> Check the RAM is seated ok and run memtest86 on it

... that wasn't. It turned out that both the DIMM (PC66) chip and
the SIMM chips I tried were defective. Strangely enough,
another (known to be good) PC133 DIMM wouldn't work at all, i.e.
the machine would even show BIOS POST screen. Anyway, thanks for
all your help, list.

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
