Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSFzc>; Sun, 19 Nov 2000 00:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQKSFzW>; Sun, 19 Nov 2000 00:55:22 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:18215 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129152AbQKSFzK>; Sun, 19 Nov 2000 00:55:10 -0500
Message-ID: <3A17640F.7AF77B5A@linux.com>
Date: Sat, 18 Nov 2000 21:24:31 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: speaking of USB...(bug/hub.c)
In-Reply-To: <3A165556.FFA4FCB6@linux.com> <20001118154042.A15356@sventech.com>
Content-Type: multipart/mixed;
 boundary="------------B84A2B079F17142BF9A1C5DA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B84A2B079F17142BF9A1C5DA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Johannes Erdfelt wrote:

> > # dmesg
> > hub.c: USB new device connect on bus1/1, assigned device number 6
> > usb-uhci.c: interrupt, status 2, frame# 121
> > usb.c: USB device not accepting new address=6 (error=-110)
> > hub.c: USB new device connect on bus1/1, assigned device number 7
>
> Status 2 means there was an error with the transfer. This doesn't look
> like a hub.c bug at all.
>
> What kind of device is this?
>
> Does this problem still happen with the other UHCI driver?

This device is any usb device I plug in.  Mouse, Kodak camera, Pegasus
network module...

I'll try with the JE driver.

-d


--------------B84A2B079F17142BF9A1C5DA
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

--------------B84A2B079F17142BF9A1C5DA--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
