Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132414AbQK3BB3>; Wed, 29 Nov 2000 20:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132428AbQK3BBT>; Wed, 29 Nov 2000 20:01:19 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:15143 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S132414AbQK3BBH>; Wed, 29 Nov 2000 20:01:07 -0500
Message-ID: <3A259FA2.1A46298E@linux.com>
Date: Wed, 29 Nov 2000 16:30:26 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Haines <rick@kuroyi.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@sourceforge.net
Subject: Re: test12-pre3 (broke my usb)
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com> <20001129183834.A443@sasami.kuroyi.net>
Content-Type: multipart/mixed;
 boundary="------------909A0FC399B49C888F2F0DC6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------909A0FC399B49C888F2F0DC6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Seems to have broken my IntelliMouse Optical (logs from the third time
> I inserted usb-uhci):
>
> Nov 29 17:12:08 sasami kernel: usb-uhci.c: Detected 2 ports
> Nov 29 17:12:08 sasami kernel: usb.c: new USB bus registered, assigned bus number 1
> Nov 29 17:12:08 sasami kernel: hub.c: USB hub found
> Nov 29 17:12:08 sasami kernel: hub.c: 2 ports detected
> Nov 29 17:12:08 sasami kernel: hub.c: USB new device connect on bus1/1, assigned device number 5
> Nov 29 17:12:11 sasami kernel: usb_control/bulk_msg: timeout
> Nov 29 17:12:11 sasami kernel: usb.c: USB device not accepting new address=5 (error=-110)
> Nov 29 17:12:11 sasami kernel: hub.c: USB new device connect on bus1/1, assigned device number 6
> Nov 29 17:12:14 sasami kernel: usb_control/bulk_msg: timeout
> Nov 29 17:12:14 sasami kernel: usb.c: USB device not accepting new address=6 (error=-110)

Actually it started several versions back.  I can frequently trigger it after an apm suspend/resume
cycle.

-d


--------------909A0FC399B49C888F2F0DC6
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------909A0FC399B49C888F2F0DC6--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
