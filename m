Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264169AbUD2Lyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbUD2Lyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 07:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUD2Lyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 07:54:49 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:33740 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264182AbUD2Lys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 07:54:48 -0400
Date: Thu, 29 Apr 2004 13:54:46 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Jesse Allen <the3dfxdude@hotmail.com>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <200404292144.37479.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0404291352200.11691@jurand.ds.pg.gda.pl>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
 <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local>
 <200404292144.37479.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Ross Dickson wrote:

> > Do you really think so?  I think there may be a resonance occuring, even with 
> > this new BIOS.  I plugged in new headphones into my nforce2 onboard sound, and 
> > get a high pitched noise.  Now here is where it gets weird:  This noise does 
> > not occur on boot until sometime after the IDE driver is loaded.  I also 
> > believe it varies under a high load.  If you disable C1 disconnect, it's gone.  
> > Also I've heard a high pitched noise at certain times coming right from the 
> > copmuter (very faint, but I do have very good hearing, I can even hear a hush 
> > sounding from my router.  my brother was quite astonished when I pointed that 
> > out)  I try to distinguish whats doing it.  It could be the hard drive.  But 
> > when I found the other sound in the head phones, I found that the sound varies 
> > almost in unison with the sound coming from the computer.  Maybe the IDE or 
> > hard drive is related, but it is too much related to C1 disconnect.
> 
> I think I might break out my oscilloscope this weekend and have a look at how 
> clean the supply rails are around the cpu and northbridge and southbridge. 
> Who knows I might get lucky and see some unexpected ripple or spikes.

 Not necessarily related to the PSU, but the noise may actually be the
reason of spurious timer interrupts.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
