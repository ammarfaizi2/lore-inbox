Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSDBLeb>; Tue, 2 Apr 2002 06:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293348AbSDBLeV>; Tue, 2 Apr 2002 06:34:21 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:26845 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S293337AbSDBLeJ>; Tue, 2 Apr 2002 06:34:09 -0500
Date: Tue, 2 Apr 2002 13:32:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <20020329230745.GD9974@elf.ucw.cz>
Message-ID: <Pine.GSO.3.96.1020402130907.26012E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002, Pavel Machek wrote:

> Overheat is not neccessarily hardware failure.

 It is the failing condition.  It need not be a result of a hardware
failure. 

> You see, I have a notebook. I put pen in it to stop the fan. Hardware
> is pretty much okay, but, well, pen does not allow fan to spin.

 A fan blockage is a hardware failure as well.  Regardless of the reason. 
It certainly isn't a software failure. 

> What's the best behaviour? Throttle is okay.

 Sure that is a way to protect the CPU but it may fail if the reason is
not heat emitted by the CPU.

> And now, you have fire at server room. All cpus throtle, then are
> burn. Does it matter if they throttled? No.

 But it matters if an operator got warned before (that is what I remarked
originally).  The operator may be in a distant location.  Or he may be
nearby and be able to act to stop the fire once he gets a message. 

> So it seems to me throttle is always right answer.

 Sure it is a way to try to recover, if hardware provides it, but it's
completely orthogonal to the question whether to report a thermal problem
or not and at which priority.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

