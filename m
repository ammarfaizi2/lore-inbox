Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTKKUSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTKKUSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:18:25 -0500
Received: from ppp-62-245-162-69.mnet-online.de ([62.245.162.69]:38528 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263447AbTKKUSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:18:24 -0500
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Julien Oster <lkml-20031111@mc.frodoid.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A7N8X (Deluxe) Madness
From: Julien Oster <lkml-20031111@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Tue, 11 Nov 2003 21:18:22 +0100
In-Reply-To: <Pine.LNX.4.44.0311112054020.30654-100000@gaia.cela.pl> (Maciej
 Zenczykowski's message of "Tue, 11 Nov 2003 20:55:16 +0100 (CET)")
Message-ID: <frodoid.frodo.87n0b2zmk1.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <Pine.LNX.4.44.0311112054020.30654-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski <maze@cela.pl> writes:

Hello Maciej,

>> So, things are totally different between 2.6.0-test9 and
>> 2.4.22-ac4. 2.6.0-test9 doesn't like the slightest IDE load with that
>> mainboard at all. 2.4.22-ac4 doesn't care, runs for hours or for days
>> and then locks up when it just gets bored or something similar.

> I'd guess one is locking up due to hard disk load,
> and the other is locking up due to automatic suspend/standby issues.
> Can you verify that the ac kernel isn't locking up due to a 'screensaver' 
> type problem?

Interesting question. I also thought about that one. However,
regarding X, the machine sometimes crashes before the X Server
screensaver (nothing special there, just the built in one that turns
the screen black) is clearing the screen and sometimes afterwards. If
it crashes afterwards, I can of course not see when it crashed, since
I don't see the clock on the screen anymore.

And there's nothing else which I could think of. I have resetted the
spinout time for the harddisks to "never" (for different reasons) and
I don't think that there's any power saving stuff enabled in BIOS
setup. I'll check that. However, I'm afraid there really isn't any
screensaver or powersaving thing within my system, of course for the
standard X screensaver, which doesn't seem related to it.

Regards,
Julien
