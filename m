Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbREVRSz>; Tue, 22 May 2001 13:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbREVRSp>; Tue, 22 May 2001 13:18:45 -0400
Received: from t2.redhat.com ([199.183.24.243]:28659 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262674AbREVRSb>; Tue, 22 May 2001 13:18:31 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15114.37415.204391.420484@gargle.gargle.HOWL> 
In-Reply-To: <15114.37415.204391.420484@gargle.gargle.HOWL>  <15113.31946.548249.53012@gargle.gargle.HOWL> <20010520165952.A9622@devserv.devel.redhat.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> <20010520164700.H4488@thyrsus.com> <25499.990399116@redhat.com> <7938.990539153@redhat.com> 
To: John Stoffel <stoffel@casc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 22 May 2001 18:17:58 +0100
Message-ID: <5080.990551878@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


stoffel@casc.com said:
>  I don't agree with this, since the current CML1 scheme has wierd,
> unwanted and wrong dependencies already, which can't (or haven't) been
> found.   Since it would be put in during the 2.5.x branching, it's
> expected that things will/can/should break, so I don't think there
> will be any dire consequences.  

OK, I obviously don't expect the behaviour to be _exactly_ identical. If 
CML2 allows the authors' intent to be more closely adhered to, that's a good 
thing. But if the CML2 files exhibit behaviour which was clearly _not_ the 
intention of the original CML1, that is a change which should be made under 
separate cover.

> Such as what?  Do you have any examples here?  

The MAC/SCSI dependencies, which it seems were 'simplified' at the cost of
preventing certain combinations which were unlikely but valid, and which it
was possible to select with the original rules.

Also of course the whole class of dependencies which people are talking 
about introducing for the benefit of the hypothetical Aunt Tillie.

I don't know how many, if any, of this kind of changes are _actually_ made
in the current CML2 rules files - what I'm saying is that there _should_ be
none. Such large changes to the policy are entirely unrelated to CML2 
itself, and should be discussed separately. 

If your response to this is "But there are no such changes, you
misunderstood the MAC/SCSI dependency conversation and the Aunt Tillie stuff
was all hypothetical, what are you talking about?", then good - that's
precisely the answer I was after.

All I'm asking for is a clear agreement that within reason, the behaviour 
of the CML2 rules files immediately after CML2 is merged will match the 
intended behaviour of the CML1 rules prior to the merge.

--
dwmw2


