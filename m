Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRAJQZW>; Wed, 10 Jan 2001 11:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131270AbRAJQZC>; Wed, 10 Jan 2001 11:25:02 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:45583 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130370AbRAJQY5>; Wed, 10 Jan 2001 11:24:57 -0500
Date: Wed, 10 Jan 2001 17:23:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mike Harrold <mharrold@cas.org>
Cc: Jakob Østergaard <jakob@unthought.net>,
        antirez <antirez@invece.org>, Brian Gerst <bgerst@didntduck.org>,
        linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
Message-ID: <20010110172333.J30055@pcep-jamie.cern.ch>
In-Reply-To: <20010110161146.A3252@unthought.net> <200101101518.KAA11519@mah21awu.cas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101101518.KAA11519@mah21awu.cas.org>; from mharrold@cas.org on Wed, Jan 10, 2001 at 10:18:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Harrold wrote:
> Be careful. *4 is not a simple <<2 substitution (by the compiler) if
> the variable is signed. *4 translates to 3 instructions (on x86) if
> it's an int.

I think you mean /4 is not the same as >>2 if the variable is signed.

In general, non-widening multiplies give the same result for signed and
unsigned variables.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
