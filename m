Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKIGKy>; Thu, 9 Nov 2000 01:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKIGKn>; Thu, 9 Nov 2000 01:10:43 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:31528 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129213AbQKIGKd>; Thu, 9 Nov 2000 01:10:33 -0500
Message-ID: <3A0A38DB.F5D63F6D@linux.com>
Date: Wed, 08 Nov 2000 21:40:43 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>, Greg KH <greg@wirex.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3427.973738139@kao2.melbourne.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------B01C18D3DC7D19C977BB351B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B01C18D3DC7D19C977BB351B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> The NMI oopser for UP only trips in when the cpu is spinning.  If the
> cpu is in a halt state then NMI does not run.  But in a halt state you
> should be able to activate kdb via the pause key.  The only time you
> cannot get kdb via pause is if interrupts are disabled (but then the
> cpu should be spinning and NMI should kick in) or if the cpu or
> motherboard is totally wedged.

just a quick followup while i'm working at it.  the hardware is totally
hung, nothing gets to it, keyboard, serial, or nmi.

being there are a lot of usb functions, does anyone have some suggested
breakpoints?

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------B01C18D3DC7D19C977BB351B
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------B01C18D3DC7D19C977BB351B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
