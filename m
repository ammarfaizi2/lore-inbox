Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbRAFVfs>; Sat, 6 Jan 2001 16:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132366AbRAFVf3>; Sat, 6 Jan 2001 16:35:29 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:42878 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S131350AbRAFVfZ>; Sat, 6 Jan 2001 16:35:25 -0500
Date: Sat, 06 Jan 2001 21:34:32 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: Crypto in 2.4
To: Jon Masters <jonathan@easypenguin.co.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A578F68.C4F4ADC7@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <3A553A03.DCFBCB9@easypenguin.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:
> 
> Hello,
> 
> I am aware of work being done to create crypto patches for 2.4 however I
> am wondering what kind of time scale is likely to be involved before a
> patch for 2.4.0 becomes available and, more importantly, when such a
> patch will be suitable for daily use (disclaimers withstanding
> obviously).
> 
> Let's just say I'm cautious after a bad experience with one of the
> previous dud patch releases :P
> 
<snip>

A 2.4.0.1 should be on ftp.kernel.org/pub/linux/kernel/crypto/v2.4/. But
it has been heavily re-worked. I haven't got my hands on that one and
will keep quiet as to what extend that patch is produiction-ready, but I
remember that the loop driver in 2.4.0 still can stall your box. Since
the kerneli crypto relies on loop, this would count in favor of "don't
do that yet".

BTW: You might want to join linux-crypto@nl.linux.org (majordomo) if you
are interested in kerneli.

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
