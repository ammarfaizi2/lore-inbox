Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314270AbSDRIXh>; Thu, 18 Apr 2002 04:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314271AbSDRIXg>; Thu, 18 Apr 2002 04:23:36 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56827 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S314270AbSDRIXf>; Thu, 18 Apr 2002 04:23:35 -0400
Date: Thu, 18 Apr 2002 10:23:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Steffen Persvold <sp@scali.com>
cc: Ingo Molnar <mingo@elte.hu>, James Bourne <jbourne@MtRoyal.AB.CA>,
        linux-kernel@vger.kernel.org,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Jeff Nguyen <jeff@aslab.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.30.0204172055470.31755-100000@elin.scali.no>
Message-ID: <Pine.GSO.3.96.1020418101902.20187F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Steffen Persvold wrote:

> Hmm, is that something ServerWorks specific because on my Plumas chipset
> the timer interrupt is balanced just fine :

 It's specific to certain timer IRQ routing setups, ServerWorks being one
of them.  I consider them braindamaged but that's just my opinion.  We
handle them fine (modulo bugs).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

