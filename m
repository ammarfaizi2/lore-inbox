Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbRE2CxS>; Mon, 28 May 2001 22:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbRE2CxH>; Mon, 28 May 2001 22:53:07 -0400
Received: from mail.family-net.net ([209.144.36.4]:2806 "EHLO
	mail.family-net.net") by vger.kernel.org with ESMTP
	id <S262017AbRE2Cwz>; Mon, 28 May 2001 22:52:55 -0400
Message-ID: <3B131036.6E66F22D@clinton-famnet.com>
Date: Mon, 28 May 2001 21:57:58 -0500
From: Terry Shull <tshull@clinton-famnet.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Brook <jbk@postmark.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Current tulip driver from 2.4.5 is plain broken
In-Reply-To: <20010529011152.9622.qmail@venus.postmark.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Brook wrote:


>  I see exactly the same (broken!) behaviour here. The last kernel
> that
> works for me in 2.4.4-ac6, which I'm running at the moment. All
> subsequent -ac kernels and 2.4.5-pre4 and above are broken. I
> reported
> the bug last week. Quick system summary: RH7.1, Duron, KT133, Network
> card chip "Digital 21041-AA". I get the same problem as above
> (working
> kernels set half-duplex, broken kernels set full-duplex). More
> details
> available on request, or at
> http://boudicca.tux.org/hypermail/linux-kernel/2001week21/0278.html
> 
>   Thanks!
> 
>     John

RH 7.1 running kernel 2.4.5-ac3, Dual Xeon 450, Supermicro S2DGE,
Network card
Macronix, Inc. [MXIC] MX987x5.

tulip-diag.c:v2.08 5/15/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Macronix 98715 PMAC adapter at 0xe800.
Macronix 98715 PMAC chip registers at 0xe800:
 0x00: fff88000 ffffffff ffffffff 1fefc000 1fefc200 e4660000 01a82202
e7ffebef
 0x40: fffe0000 0fffcf08 ffffffff fffe0000 40a1d0cc ffff0000 ffffffff
fff00000
 Extended registers:
 80: 0f340000 0f340000 0f340000 0f340000 0f340000 0f340000 fc4ffff0
f84ffff0
 a0: 2001527f 2001527f 2001527f 2001527f 2001527f 2001527f 2001527f
2001527f
 c0: 2001527f 2001527f 2001527f 2001527f 2001527f 2001527f 2001527f
2001527f
 e0: 2001527f 2001527f 2001527f 2001527f 2001527f 2001527f 2001527f
2001527f
 Port selection is 10mpbs-serial 100baseTx scrambler, full-duplex.
 Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
EEPROM 64 words, 6 address bits.
 A simplifed EEPROM data table was found.
 The EEPROM does not contain transceiver control information.
   No MII transceivers found!

Works great, no problems at all.
