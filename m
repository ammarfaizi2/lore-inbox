Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbQLYSzy>; Mon, 25 Dec 2000 13:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbQLYSze>; Mon, 25 Dec 2000 13:55:34 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:2710 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130682AbQLYSzc>; Mon, 25 Dec 2000 13:55:32 -0500
Message-ID: <3A479102.C7611586@rcn.com>
Date: Mon, 25 Dec 2000 13:25:06 -0500
From: Marvin Stodolsky <stodolsk@rcn.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Mares <mj@suse.cz>
CC: linux-kernel@vger.kernel.org, Jacques.Goldberg@cern.ch,
        Mark Spieth <mark@digivation.com.au>, Sean Walbran <sean@walbran.org>
Subject: Re: BIOS problem, pro Microsoft, anti other OS
In-Reply-To: <3A4769AC.F38B372C@rcn.com> <20001225170914.A15598@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacques

> Can you check what does Linux 2.4.0-test<latest> behave, please?
Are you comfortable compiling kernels?
If not I'll compile one for you for the test.
Currently I'm happily under 2.4.0-test 12: 
   lsmod:
Module                  Size  Used by
ppp_deflate            39164   1  (autoclean)
bsd_comp                4148   0  (autoclean)
ppp_async               6220   1  (autoclean)
ppp_generic            12820   2  (autoclean) [ppp_deflate bsd_comp
ppp_async]
ltmodem               364948   1
input                   3328   0
serial                 42192   1  (autoclean) (ONLY suporting my mouse)
isa-pnp                27528   0  (autoclean) [ltmodem serial]
usbcore                27684   0  (unused) 

Martin  
   Are there any particular kernel config choices that will be
beneficial for this problem?

Mark
> You probably should make the ltmodem driver check the region base
> registers and interrupts and if they are not set, recommend the user to
> change the OS or PNP settings in their BIOS setup.
Can these be included in the LTmodem packages you are working up?

MarvS
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
