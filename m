Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSGNLCG>; Sun, 14 Jul 2002 07:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSGNLCG>; Sun, 14 Jul 2002 07:02:06 -0400
Received: from [212.143.73.98] ([212.143.73.98]:59893 "EHLO
	hawk.exanet-il.co.il") by vger.kernel.org with ESMTP
	id <S315762AbSGNLCF> convert rfc822-to-8bit; Sun, 14 Jul 2002 07:02:05 -0400
content-class: urn:content-classes:message
Subject: route cache corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Sun, 14 Jul 2002 13:53:42 +0200
X-MIMEOLE: Produced By Microsoft Exchange V6.0.4712.0
Message-ID: <4913AB320D31DC4798D6FEF5F557351F159764@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: route cache corruption
Thread-Index: AcIrLXARz1NF+NukR0ObSwzTUTvkmA==
From: "Nir Soffer" <nirs@exanet.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

We've been having some problems with the route cache corrupting on us,
suddenly every connection we made went out to the loopback interface,
and right back in the machine.

I've seen a patch in the 2.4.19 changelog headline:
"        Terrible bug in ipv4/route.c, mis-sized ip_rt_acct leads to"

Could this be the cause of this phenomena, or am I barking up the
wrong tree?

I'm currently running a modified 2.4.18-4. I'm aware that straying
from the vanilla is a recipe for trouble - but I'm wondering if this
specific problem could be caused by this bug. I haven't found anything
in the archives telling me what exactly this bug does. All I've seen
are references to it.

Thanks for any help you can give me!

Nir.


--
Nir Soffer -=- Software Engineer, Exanet Inc. -=-
"Father, why are all the children weeping? / They are merely crying son
 O, are they merely crying, father? / Yes, true weeping is yet to come"
        -- Nick Cave and the Bad Seeds, The Weeping Song
 
