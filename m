Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132196AbRBESnS>; Mon, 5 Feb 2001 13:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132175AbRBESnI>; Mon, 5 Feb 2001 13:43:08 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:51974 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S131801AbRBESm6>; Mon, 5 Feb 2001 13:42:58 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE636@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Benson Chow'" <blc@q.dyndns.org>, linux-kernel@vger.kernel.org
Subject: RE: ACPI weirdness in 2.4.1 ? (!!)
Date: Mon, 5 Feb 2001 10:42:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

ACPI idle is pretty broken at the moment, as you've seen.

The next ACPI patch (early next week maybe?) will have some more messages to
help me fix this, as well as a cmdline option to not use ACPI for idle.

> From: Benson Chow [mailto:blc@q.dyndns.org]
> ACPI: System firmware supports: C2
> ACPI: System firmware supports: S0 S1 S4 S5
> 
> ACPI: System firmware supports: C2 C3                    <- NEW!!!?!
> ACPI: System firmware supports: S0 S1 S4 S5

> (seems acpi changed in 2.4.0-2.4.1.  and suddenly my hardware supports
> C3 whereas in 2.4.0 it doesn't???)

> Then things run
> VERY slowly.  I mean, 10 minutes to boot to text login, as if I were

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
