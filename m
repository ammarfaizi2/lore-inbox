Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131190AbRBDAnu>; Sat, 3 Feb 2001 19:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbRBDAnk>; Sat, 3 Feb 2001 19:43:40 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:61447 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131190AbRBDAnf>;
	Sat, 3 Feb 2001 19:43:35 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102040040.f140emO484456@saturn.cs.uml.edu>
Subject: Re: Better battery info/status files
To: chromi@cyberspace.org (Jonathan Morton)
Date: Sat, 3 Feb 2001 19:40:48 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), pavel@suse.cz (Pavel Machek),
        andrew.grover@intel.com, linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <l03130321b6a24b3546f2@[192.168.239.105]> from "Jonathan Morton" at Feb 04, 2001 12:03:25 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The units seem to vary. I suggest using fundamental SI units.
>> That would be meters, kilograms, seconds, and maybe a very
>> few others -- my memory fails me on this.
>
> There are lots of SI units, one for each physical dimension
> that can be measured.  Some of the ones that might apply here are:
>
> - Volts
> - Coulombs
> - Watts
> - Amperes
> - Seconds
> - Joules

No, these are not all fundamental.

1 Joule == 1 newton * 1 meter

The newton isn't fundamental either. It is defined in terms
of meters, seconds, and kilograms.

So if I've not mucked something up, 1 J == 1 m*kg*m/s/s.

Units get ugly when arbitrary powers of 10 get thrown in,
and worse with random odd constants. Amperes have a 2.0e-7
in the definition.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
