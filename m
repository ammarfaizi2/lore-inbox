Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311605AbSCTNt4>; Wed, 20 Mar 2002 08:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311640AbSCTNta>; Wed, 20 Mar 2002 08:49:30 -0500
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:30677 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S311615AbSCTNtF>; Wed, 20 Mar 2002 08:49:05 -0500
Date: Wed, 20 Mar 2002 14:47:05 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.GSO.3.96.1020320121631.13532A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0203201438250.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Maciej,

thanks for your comments and the patch. I overlooked that NMI watchdog
thing. I'll test it, although I am certain that it'll fix our problem.

Btw, we _have_ already fixed our BIOS (at least on my test machine).
I just submitted the patch because I thought that Linux putting the
8259A in polling mode is also a dangerous thing that should be avoided
if possible. You have shown me that there are some more situations where
it is impossible than I had seen.

Many people seem to think our BIOS is particularly nasty. I'd like to
repeat that this is a pretty common Phoenix BIOS. Of course I can't tell
what other manufacturers do, but I'd consider it at least possible that
their BIOS's act similarly.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





