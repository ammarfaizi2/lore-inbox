Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKIB2A>; Wed, 8 Nov 2000 20:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKIB1v>; Wed, 8 Nov 2000 20:27:51 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:63271 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129092AbQKIB1j>; Wed, 8 Nov 2000 20:27:39 -0500
Message-ID: <3A09FD81.E7DA9352@linux.com>
Date: Wed, 08 Nov 2000 17:27:29 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: georgn@somanetworks.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com>
Content-Type: multipart/mixed;
 boundary="------------DF689D1C6A7866386964E947"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF689D1C6A7866386964E947
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I just recompiled using the JE driver and it doesn't lock up on boot.

-d

Georg Nikodym wrote:

> >>>>> "DF" == David Ford <david@linux.com> writes:
>
>  DF> Ok, in test10, for every 2 out of 5 boots, this particular
>  DF> workstation locks up hard as it reaches the following:
>
> I have a similar problem.  My work around is to, by hand, modprobe
> usbmouse, wait, modprobe usb-uhci...

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------DF689D1C6A7866386964E947
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

--------------DF689D1C6A7866386964E947--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
