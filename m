Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281633AbRKUHBi>; Wed, 21 Nov 2001 02:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281638AbRKUHB3>; Wed, 21 Nov 2001 02:01:29 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:18181
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S281633AbRKUHBM>; Wed, 21 Nov 2001 02:01:12 -0500
Message-Id: <5.1.0.14.2.20011121014157.01d557b0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Nov 2001 01:57:13 -0500
To: "linux kernel" <linux-kernel@vger.kernel.org>
From: Stevie O <stevie@qrpff.net>
Subject: Re: if (a & X || b & ~Y) in dasd.c
In-Reply-To: <200111191938.fAJJckA14340@oboe.it.uc3m.es>
In-Reply-To: <200111191840.fAJIej230821@deathstar.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:38 PM 11/19/2001 +0100, Peter T. Breuer wrote:

>"bill davidsen wrote:"
> >   If the code does what I think it does, it works as written. However, I
> > usually would throw in parenthesis on something like this to be sure
> > that the next person reading the code won't waste time thinking about
>
>Which is WHY you do not put in parentheses.

<snip snip>

So instead of using extra parentheses, we should include a copy of your 
response in every potentially ambiguous location instead?

Two C constructs that have bitten me in the glutinous maximus on more than 
one occasion:


mem_address = mem_base + page_index << 12;      // Wrong!

if ( bit_mask & BIT_FLAG == 0) { flag_not_set(); }      // Wrong!

Of course C has precedence. It's not always obvious. And the difference 
between this

x = y + z << 2;

and

x = (y + z) << 2;

is that the 2nd doesn't make me have to remember the relative precedences 
of + and <<.


--
Stevie-O

REAL kernel hackers use
# cat > /vmlinuz
and
# insmod /dev/stdin

