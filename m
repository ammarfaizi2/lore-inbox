Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272406AbRIKLVh>; Tue, 11 Sep 2001 07:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272399AbRIKLV2>; Tue, 11 Sep 2001 07:21:28 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:8718 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272401AbRIKLVO>;
	Tue, 11 Sep 2001 07:21:14 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100303b7c3a4283667@[192.168.239.101]>
Date: Tue, 11 Sep 2001 12:21:22 +0100
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo KT133A
>chipset). The kernel I had (2.4.9) started crashing on boot with an
>invalid page fault, usually right after starting init. I tryed a i686
>kernel and noticed it works OK, so I recompiled my crashy kernel only
>switching the processor type and it also worked. changed it back to
>Athlon/K7/Duron and it starts crashing.
>
>Anyone else experiencing this?

BINGO!

This problem is known about, but this is the first report we've had 
of it on a Duron (as opposed to Athlon), and you've successfully 
tracked it down to the updated BIOS.

We need the versions of your old and new BIOSes, as accurately as you 
can make it.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
