Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTIQMpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTIQMpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:45:00 -0400
Received: from mail.native-instruments.de ([217.9.41.138]:18121 "EHLO
	mail.native-instruments.de") by vger.kernel.org with ESMTP
	id S262740AbTIQMo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:44:58 -0400
Message-ID: <00c501c37d19$7eb34c80$9602010a@jingle>
From: "Florian Schirmer" <jolt@tuxbox.org>
To: "Kjartan Maraas" <kmaraas@broadpark.no>, <linux-kernel@vger.kernel.org>
References: <wJBI.3Mx.7@gated-at.bofh.it>
Subject: Re: Problems with Synaptics touchpad on Compaq Evo N600c and 	2.6.0-test5
Date: Wed, 17 Sep 2003 14:44:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i can confirm this on a HP Pavilion ze5343ea. Booting with "psmouse_noext=1"
works around it.

Regards,
    Florian

----- Original Message ----- 
From: "Kjartan Maraas" <kmaraas@broadpark.no>
Newsgroups: linux.kernel
Sent: Wednesday, September 17, 2003 2:30 PM
Subject: Problems with Synaptics touchpad on Compaq Evo N600c and
2.6.0-test5


> I tried booting this kernel from http://people.redhat.com/arjanv/2.5/
> and lost my mouse completely. Here's a snippet from /var/log/messages
>
> Sep 17 12:45:13 localhost kernel: mice: PS/2 mouse device common for all
> mice
> Sep 17 12:45:13 localhost kernel: i8042.c: Detected active multiplexing
> controller, rev 1.1.
> Sep 17 12:45:13 localhost kernel: serio: i8042 AUX0 port at 0x60,0x64
> irq 12
> Sep 17 12:45:13 localhost kernel: serio: i8042 AUX1 port at 0x60,0x64
> irq 12
> Sep 17 12:45:13 localhost kernel: serio: i8042 AUX2 port at 0x60,0x64
> irq 12
> Sep 17 12:45:13 localhost kernel: synaptics reset failed
> Sep 17 12:45:13 localhost last message repeated 2 times
> Sep 17 12:45:13 localhost kernel: Synaptics Touchpad, model: 1
> Sep 17 12:45:13 localhost kernel:  Firware: 5.8
> Sep 17 12:45:13 localhost kernel:  180 degree mounted touchpad
> Sep 17 12:45:13 localhost kernel:  Sensor: 27
> Sep 17 12:45:13 localhost kernel:  new absolute packet format
> Sep 17 12:45:13 localhost kernel:  Touchpad has extended capability bits
> Sep 17 12:45:13 localhost kernel:  -> multifinger detection
> Sep 17 12:45:13 localhost kernel:  -> palm detection
> Sep 17 12:45:13 localhost kernel: input: Synaptics Synaptics TouchPad on
> isa0060/serio4
>
> I've been testing with the XFree86 packages from rawhide, updated as of
> today, and the mouse works ok with the 2.4.x kernel from the same place.
>
> I've got the latest BIOS for this laptop if that matters.
>
> Cheers
> Kjartan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

