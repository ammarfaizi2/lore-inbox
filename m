Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSCTONp>; Wed, 20 Mar 2002 09:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSCTONh>; Wed, 20 Mar 2002 09:13:37 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:28856 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S287149AbSCTONU>; Wed, 20 Mar 2002 09:13:20 -0500
Date: Wed, 20 Mar 2002 15:13:22 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203201438250.9609-100000@biker.pdb.fsc.net>
Message-ID: <Pine.GSO.3.96.1020320145347.13532C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Martin Wilck wrote:

> I just submitted the patch because I thought that Linux putting the
> 8259A in polling mode is also a dangerous thing that should be avoided
> if possible. You have shown me that there are some more situations where
> it is impossible than I had seen.

 I don't think it's dangerous on sane systems -- the 8259A is such an old
and simple chip there is no excuse for not getting appropriate knowledge
on it before working on it both from the hardware and the software's
points of view.  There is no need to waste cycles, of course.

> Many people seem to think our BIOS is particularly nasty. I'd like to
> repeat that this is a pretty common Phoenix BIOS. Of course I can't tell
> what other manufacturers do, but I'd consider it at least possible that
> their BIOS's act similarly.

 Well, experience shows BIOSes tend to be nasty -- I don't think yours is
particular here, although bugs may differ. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

