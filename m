Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGQBb>; Wed, 7 Feb 2001 11:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBGQBV>; Wed, 7 Feb 2001 11:01:21 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:48530 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129026AbRBGQBK>; Wed, 7 Feb 2001 11:01:10 -0500
Date: Wed, 7 Feb 2001 16:56:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: mingo@redhat.com, linux-kernel@vger.kernel.org, hpa@transmeta.com,
        mikpe@csd.uu.se
Subject: Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <20010207135824.A24476@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1010207165119.1418A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Petr Vandrovec wrote:

>   Mikael Pettersson pointed to me that current kernel code should not
> reenable local APIC on AMD K7, as it tests boot_cpu_data.x86_vendor.
> But boot_cpu_data.x86_vendor is uninitialized (or contains wrong
> value) when detect_init_APIC is invoked.

 I'm working on CPU capabilities now.  I'll address the problem.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
