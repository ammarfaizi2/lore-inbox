Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130931AbRBCXZv>; Sat, 3 Feb 2001 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130763AbRBCXZm>; Sat, 3 Feb 2001 18:25:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:27911 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129758AbRBCXZa>;
	Sat, 3 Feb 2001 18:25:30 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102032322.f13NMZp438329@saturn.cs.uml.edu>
Subject: Re: Better battery info/status files
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 3 Feb 2001 18:22:34 -0500 (EST)
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010202155341.A149@bug.ucw.cz> from "Pavel Machek" at Feb 02, 2001 03:53:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This fixes units, and makes format tag: value. Please apply.

The units seem to vary. I suggest using fundamental SI units.
That would be meters, kilograms, seconds, and maybe a very
few others -- my memory fails me on this.

Power meter applets will be eternally buggy if you force them
to deal with units that change. In fact there is no reason to
print the units if you always use the fundamental units.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
