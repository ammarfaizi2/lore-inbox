Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130298AbQKAXyO>; Wed, 1 Nov 2000 18:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbQKAXxy>; Wed, 1 Nov 2000 18:53:54 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:22029 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131104AbQKAXxp>;
	Wed, 1 Nov 2000 18:53:45 -0500
Date: Thu, 2 Nov 2000 00:53:37 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: mdaljeet@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: system call handling
Message-ID: <20001102005337.A9017@pcep-jamie.cern.ch>
In-Reply-To: <CA25698A.00434741.00@d73mta05.au.ibm.com> <Pine.LNX.3.95.1001101073637.6028A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1001101073637.6028A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Nov 01, 2000 at 07:44:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> If you designed it with just one call-gate, with one entry point,
> you would have exactly what we have now except you would execute
> a `call CALL_GATE` instead of `int 0x80`. This turns out to be
> 6 of one and 1/2 dozen of another when it comes to performance.

The final decider is that `int 0x80' is only two bytes long.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
