Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRAJQ0c>; Wed, 10 Jan 2001 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRAJQ0W>; Wed, 10 Jan 2001 11:26:22 -0500
Received: from srv01s4.cas.org ([134.243.50.9]:43496 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S132117AbRAJQ0L>;
	Wed, 10 Jan 2001 11:26:11 -0500
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200101101626.LAA12262@mah21awu.cas.org>
Subject: Re: * 4 converted to << 2 for networking code
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Wed, 10 Jan 2001 11:26:01 -0500 (EST)
Cc: mharrold@cas.org (Mike Harrold),
        jakob@unthought.net (Jakob Østergaard),
        antirez@invece.org (antirez), bgerst@didntduck.org (Brian Gerst),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010110172333.J30055@pcep-jamie.cern.ch> from "Jamie Lokier" at Jan 10, 2001 05:23:33 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Mike Harrold wrote:
> > Be careful. *4 is not a simple <<2 substitution (by the compiler) if
> > the variable is signed. *4 translates to 3 instructions (on x86) if
> > it's an int.
> 
> I think you mean /4 is not the same as >>2 if the variable is signed.
> 
> In general, non-widening multiplies give the same result for signed and
> unsigned variables.
> 

I believe you're right. Teach me to post before morning coffee :)

/Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
