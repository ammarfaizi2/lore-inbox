Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314215AbSDRBwi>; Wed, 17 Apr 2002 21:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314216AbSDRBwh>; Wed, 17 Apr 2002 21:52:37 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:22819 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S314215AbSDRBwg>; Wed, 17 Apr 2002 21:52:36 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A78177F10@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Martin J. Bligh'" <Martin.Bligh@us.ibm.com>,
        "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        "'Robert Love'" <rml@tech9.net>
Cc: James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: RE: Hyperthreading
Date: Wed, 17 Apr 2002 20:52:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> (Though check Anandtech, he did a benchmark on his DB, and got a small
>> performance Decrease on a test!)

>Thanks for the pointer.

Also, it looks like the Athlon MP still stacks up quite nice in his more or
less real world benchmark, even against an pair of Hyperthreaded ZEON's.

>It sounds like a good idea in theory, but the fact that they share the TLB
>cache and other things makes me rather dubious about whether it's really
>worth it. I'm not saying it's necessarily bad, I'm just not convinced it's
good
>yet. Introducing more processors to the OS has it's own problems to deal 
>with (ones we're interested in solving anyway).

I'll bet it'll be interesting, and I agree, I was dubious about the P4 at
first anyway.. :o)  Though Hyperthreading will only be in the ZEON.   

>Real world benchmarks from people other than Intel should make interesting
>reading .... I think we need some more smarts in the OS to take real
advantage
>of this (eg using the NUMA scheduling mods to create cpu pools of 2 "procs"
>for each pair, etc) ... will be fun ;-)

>From the docs, it looks like maybe some scheduling smarts could be added.
Run Floating point ops on one Logical processor, and normal ops on the
other, and maybe some other parallelism mods.  

