Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRDQLDa>; Tue, 17 Apr 2001 07:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDQLDU>; Tue, 17 Apr 2001 07:03:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:10561 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131820AbRDQLDL>;
	Tue, 17 Apr 2001 07:03:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: CML2 1.1.3 is available
In-Reply-To: <3ADB69BF.7040305@reutershealth.com> <Pine.GSO.4.05.10104161622110.17365-100000@pipt.oz.cc.utah.edu> <20010416205556.A22960@thyrsus.com> <20010416202820.A22319@cadcamlab.org> <20010416232048.B23989@thyrsus.com>
Date: Tue, 17 Apr 2001 12:25:57 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14pSgH-0000NJ-00@hunte.bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > telling us the Tk library, which for 8 or 10 years has been pretty much
> > *the* X toolkit/widget set for scripting, does not include an interface
> > to X resources?

Of course it does; in an idiosyncratic way (not directly using X
resources) but it does use the X resource file syntax.

> If it does, it's not in any of the documentation I've ever seen.

It's in Ousterhout's Tcl/Tk book as well as in the Perl/Tk intro by
Walsh. ;-) Tk calls this "option database" or similar. The only catch
is that it needs to be explicitly loaded, see "optionReadfile" (at
least that's what it's called in perl/tk).

Olaf

