Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSD2SB7>; Mon, 29 Apr 2002 14:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSD2SB6>; Mon, 29 Apr 2002 14:01:58 -0400
Received: from dnvrdslgw14poolA183.dnvr.uswest.net ([63.228.84.183]:62503 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S313911AbSD2SB6>;
	Mon, 29 Apr 2002 14:01:58 -0400
Date: Mon, 29 Apr 2002 12:02:05 -0600 (MDT)
From: Benson Chow <blcspam@q.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: GW Solo 5350 Laptop APIC trouble?
Message-ID: <Pine.LNX.4.44.0204291201130.30525-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.18 on my GW Solo 5350, and if I compile APIC in for
uniprocessors, it will fail pretty horribly - something like this:

APIC + APM: System Freeze on idle, random time, instant Fn key freeze.
APIC + ACPI: System Freeze when using Fn key with smm feature.
APM w/o APIC: Works fine, but Fn key instant on-screen status info is
corrupt
ACPI w/o APIC: Haven't tried yet.
Redhat 7.2 Kernel (2.4.9-RH I believe): No crashes, Fn-key onscreen works
fine.

(smm=system management mode)

I'm still trying to figure out what's in the RH kernel that makes it work
fine, that's when I found out compiling in APIC aggravated the failures.

Apparently ACPI can't read battery info from the laptop yet.  Or at least
I haven't figured out a way to do so yet...

Anyone have any ideas how to start debugging this?  Chances are it's a
hardware issue, I hope it can be worked around in software without
outrightly disabling or not using the features.

Thanks,

-bc

To reply to sender, get rid of the spam.

