Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129766AbQKIEUF>; Wed, 8 Nov 2000 23:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbQKIETy>; Wed, 8 Nov 2000 23:19:54 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:18984 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129044AbQKIETn>; Wed, 8 Nov 2000 23:19:43 -0500
Message-ID: <3A0A25C1.C46E392B@linux.com>
Date: Wed, 08 Nov 2000 20:19:13 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com> <3A09FD81.E7DA9352@linux.com> <20001108200844.A13446@wirex.com>
Content-Type: multipart/mixed;
 boundary="------------C1DD0D201A4195B5A8E5036B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C1DD0D201A4195B5A8E5036B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am going thru the steps atm.  The JE driver also hangs.

More information.  I have an external USB 4 port hub, in which I have one
logitech mouse at the moment.  I can cold boot and reboot to my heart's
delight fine.  But if I unplug/plug in the mouse and reboot, it will hang.
Note, I have to unplug and plug back in the mouse to get it recognized by
the system before I can use it.

So we're probably looking at something other than the uhci/je driver.

-d

Greg KH wrote:

> If you have the time, could you please do the debugging steps that Keith
> Owens just listed.  It might enable us to determine what is wrong with
> the usb-uhci.o driver (the JE driver doesn't work with all devices right
> now, so we are still dependent on usb-uhci.o).

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------C1DD0D201A4195B5A8E5036B
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

--------------C1DD0D201A4195B5A8E5036B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
