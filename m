Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276389AbRI2AkU>; Fri, 28 Sep 2001 20:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276388AbRI2AkA>; Fri, 28 Sep 2001 20:40:00 -0400
Received: from [212.1.130.3] ([212.1.130.3]:39440 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S276387AbRI2Aj6>;
	Fri, 28 Sep 2001 20:39:58 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100304b7dac7cac7e3@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0109281452330.4008-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109281452330.4008-100000@penguin.transmeta.com>
Date: Sat, 29 Sep 2001 01:37:46 +0100
To: Linus Torvalds <torvalds@transmeta.com>,
        "Grover, Andrew" <andrew.grover@intel.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: RE: CPU frequency shifting "problems"
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <padraig@antefacto.com>,
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > APM is a lost cause, but the correct solution for ACPI systems is 
>to use the
>>  PM timer.
>
>This is _completely_ untrue.
>
>The PM timer is (a) inaccurate and (b) slow as hell.
>
>Linux uses TSC because we want high accuracy (nanosecond scale) without
>having slow stuff.

Please, don't confuse accuracy with precision.  The TSC is precise 
but not accurate.  The 100Hz timer is more accurate, especially given 
a SpeedStep CPU, but much less precise.  It's a subtle distinction, 
but an important one.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
