Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRAJWOX>; Wed, 10 Jan 2001 17:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132108AbRAJWOO>; Wed, 10 Jan 2001 17:14:14 -0500
Received: from mail.barryscott.com ([216.207.134.34]:16906 "HELO
	mail.barryscott.com") by vger.kernel.org with SMTP
	id <S131429AbRAJWOG>; Wed, 10 Jan 2001 17:14:06 -0500
Message-Id: <5.0.2.1.2.20010110171427.00a5cb70@mail.barryscott.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 10 Jan 2001 17:14:33 -0500
To: linux-kernel@vger.kernel.org
From: Mike Lieman <os-support@barryscott.com>
Subject: Re: 2.4.0 and "LSR safety check engaged!\n"
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

I think we're experiencing the same issue.  Could you fire up minicom 
(under 2.4) , connect to another box, and do a directory listing to see if 
you have the same lost characters/"flow control" looking issue I'm 
experiencing...  It's rock solid on 2.2.18.

peace
Mike


At 04:23 PM 1/10/01 -0500, you wrote:
>I get the subject message when trying to initiate a PPP connection over
>an internal USR 56k/flex modem defined as /dev/ttyS0.
>
>It happens with both diald and chat(from PPP).
>
>The "LSR safety check engaged!\n" message then causes this (diald):
>diald[407]: failed to get initial modem terminal attributes: Input/output 
>error
>diald[407]: could not get initial terminal attributes: Input/output error
>diald[407]: failed to set terminal attributes: Input/output error
>chat[803]: Can't get terminal parameters: Input/output error
>
>The serial support at boot is:
>Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT 
>SHARE_IRQ SERIAL_PCI enabled
>ttyS00 at 0x03f8 (irq = 4) is a 16550A
>ttyS01 at 0x02f8 (irq = 3) is a 16550A
>
>Any clues ?  This is keeping me at 2.2.19prex for the nonce.
>
>Thanks,
>--
>Rick Nelson
>Life'll kill ya                         -- Warren Zevon
>Then you'll be dead                     -- Life'll kill ya
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=-
Mike Lieman -- CIO                           mikelieman@barryscott.com
The Barry Scott Companies                      (518) 452-8560 ext. 114

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
