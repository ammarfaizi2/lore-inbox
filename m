Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbQLKEAe>; Sun, 10 Dec 2000 23:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbQLKEAQ>; Sun, 10 Dec 2000 23:00:16 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:27654 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129738AbQLKEAG>; Sun, 10 Dec 2000 23:00:06 -0500
Message-ID: <3A344A1C.D0CA640D@Hell.WH8.TU-Dresden.De>
Date: Mon, 11 Dec 2000 04:29:32 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Andrey Savochkin <saw@saw.sw.com.sg>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0012101901030.5164-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:

> This is an i82559 C-step. What kind of switch is it attached to?

It's a 3Com FDDI/Ethernet Linkswitch 2200 Rev 2.8

> Also, if you feel like experimenting, edit speedo_interrupt() and change
>         outw(status & 0xfc00, ioaddr + SCBStatus);
> to
>         outw(status & 0xff00, ioaddr + SCBStatus);

[rest snipped]

Ok, I'll try that this afternoon and post the results, since it's 4:30am
now and I have yet to try the sleep thing.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
