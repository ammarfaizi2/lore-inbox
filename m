Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSGTVnn>; Sat, 20 Jul 2002 17:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSGTVnn>; Sat, 20 Jul 2002 17:43:43 -0400
Received: from perfo.perfopol.pl ([213.25.186.10]:39430 "EHLO mail.perfopol.pl")
	by vger.kernel.org with ESMTP id <S317540AbSGTVnm> convert rfc822-to-8bit;
	Sat, 20 Jul 2002 17:43:42 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Impressions of IDE 98?
References: <Pine.LNX.4.44.0207192249500.3378-100000@hawkeye.luckynet.adm>
X-Attribution: arekm
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
Organization: PLD Linux Distribution Team
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Date: 20 Jul 2002 17:18:08 +0200
In-Reply-To: <Pine.LNX.4.44.0207192249500.3378-100000@hawkeye.luckynet.adm>
Message-ID: <87k7nqctsf.fsf@arm.t19.ds.pwr.wroc.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.90
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@ngforever.de> writes:

> Hi,
> 
> I don't have any IDE machines handy, and since these problems that IDE had 
> in the last days, I wonder what's become of it. Has anyone been so brave 
> as to try out 2.5.26 w/the included IDE (IDE 98)? How is it?
On my Duron system where LG CD-RW GCE-8320B is connected as hda to
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
and three IDE discs (hde: IBM-DTLA-307030 [30GB], hdg: ST380021A [80GB],
hdh: ST360021A [60GB]) connected to:
00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
2.5.26+xfs patch boots, detects VIA IDE controller, finds my cdrw
and stops - no oops just booting stops, HDD LED (connected to promise
controller) is on. Nothing more happens.

On 2.4.18 + Hedrick patches there is no problem.

> 							Thunder

-- 
Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr
