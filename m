Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLKI4E>; Mon, 11 Dec 2000 03:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLKIzy>; Mon, 11 Dec 2000 03:55:54 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:36607 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129655AbQLKIzn>; Mon, 11 Dec 2000 03:55:43 -0500
Message-Id: <5.0.2.1.2.20001211080948.03fedb80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 11 Dec 2000 08:19:05 +0000
To: Ion Badulescu <ionut@cs.columbia.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: eepro100 driver update for 2.4
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012101901030.5164-100000@age.cs.columbia.ed
 u>
In-Reply-To: <3A341B3F.B5D962A8@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:16 11/12/2000, Ion Badulescu wrote:
>On Mon, 11 Dec 2000, Udo A. Steinberg wrote:
>Anton Altaparmakov wrote:
> > > My card is an Ether Express Pro 100, lcpci says: Intel Corporation 82557
> > > [Ethernet Pro 100] (rev 04)
>
>So it's an i82558 A-step. That's interesting, the patch shouldn't have
>made any difference on an i82558, at least according to the documentation.

I'll give test12-pre7 a try without the patch and see if the messages 
reappear. - With the patch it the box has been running all night without a 
single no resources message from the EEPro.

> > > and lspci -n gives: class 0200: 10b7:9004
>
>Umm.. I don't think so. :) This a 3Com 3c900B. You probably got the wrong
>entry, in case you have multiple cards in that box.

Sorry. Slipped by one line (box has several network cards - only the eepro 
gives the no resources messages, the 3com's are fine). The right one line 
is: 0200: 8086:1229 (rev 04)

Anton


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
