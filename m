Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbSAATCf>; Tue, 1 Jan 2002 14:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283097AbSAATCZ>; Tue, 1 Jan 2002 14:02:25 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:46852 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S283054AbSAATCU>; Tue, 1 Jan 2002 14:02:20 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Harald Holzer" <harald.holzer@eunet.at>, <linux-kernel@vger.kernel.org>
Subject: RE: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Tue, 1 Jan 2002 11:02:18 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBMEAKEFAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16LTvs-00016I-00@the-village.bc.nu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2. Isn't the boundary at 2^30 really irrelevant and the three "correct"
> > zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 - 2^36-1)?
>
> Nope. The limit for directly mapped memory is 2^30.

Ouch! That makes low memory *extremely* precious. Intuitively, the demand
for directly mapped memory will be proportional to the demand for all
memory, with a proportionality constant depending on the purpose for the
system and the efficiency of the application set. We've seen (apparently --
I haven't looked at any data, just messages on the list) cases where we can
force this to happen with benchmarks designed to embarrass the VM :)) but
have we seen it in real applications?

Thanks for taking the time to answer these questions. I'm struggling to
understand where the performance walls are in large i686 systems, in both
Linux and Windows. In the end, though, relentless application of Moore's Law
to the IA64 must be the correct answer :)).
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

