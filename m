Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTK1SAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTK1SAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:00:10 -0500
Received: from ppp-62-245-210-190.mnet-online.de ([62.245.210.190]:35466 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S262775AbTK1SAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:00:06 -0500
To: ross.alexander@uk.neceur.com
Cc: "Brendan Howes" <brendan@netzentry.com>, linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>
From: Julien Oster <lkml-7439@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Fri, 28 Nov 2003 19:00:03 +0100
In-Reply-To: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com> (ross
 alexander's message of "Fri, 28 Nov 2003 15:13:45 +0000")
Message-ID: <frodoid.frodo.874qwo9xwc.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ross.alexander@uk.neceur.com writes:

Hello Ross,

> I have been test various kernel parameter combinations to test stability.

Thanks, that's quite a nice overview.

But something seems strange:

> APIC,LAPIC                                              S
> PREM,APIC,LAPIC                                         S

Does those two lines mean, that using ACPI, APIC and local APIC
enabled is stable, as long as your kernel is not an SMP kernel? If
yes, then I can't confirm this. I run strictly non-SMP kernels and
they always crash if APIC (or local APIC?) is enabled.

BTW, I use a very quick test to see if the system is stable, that also
can be performed when booting with a "read-only init=/bin/bash" LILO
command line (so that no filesystem will need to fsck after a crash):
just type hdparm -t /dev/hd<someharddrive> several times.

Regards,
Julien
