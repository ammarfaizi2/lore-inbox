Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRBJRU5>; Sat, 10 Feb 2001 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbRBJRUr>; Sat, 10 Feb 2001 12:20:47 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:44287 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP
	id <S129489AbRBJRUi>; Sat, 10 Feb 2001 12:20:38 -0500
Message-ID: <7630470.981825632015.JavaMail.webmail1@wm-java1.fg.online.no>
Date: Sat, 10 Feb 2001 18:20:32 +0100 (CET)
From: Ole Andre Vadla Ravnaas <oleavr@online.no>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-pre3 and 2.4.1-ac9 sound corruption
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="31522415.981825632005.JavaMail.webmail1@wm-java1.fg.online.no"
X-Mailer: Online Epostleser
X-Real-User: oleavr
X-Client-Addr: 213.142.78.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--31522415.981825632005.JavaMail.webmail1@wm-java1.fg.online.no
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: quoted-printable

I've been using vanilla 2.4.1 with no problems, with my soundcard (SB PCI 1=
28 / es1370) sharing IRQ with the USB-controller (this is an Abit KT7-RAID =
motherboard).
This is what /proc/interrupts tells me:
           CPU0
  0:     130808          XT-PIC  timer
  1:        564          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:      12256          XT-PIC  usb-uhci, usb-uhci, es1370
 10:        503          XT-PIC  eth0
 11:       2916          XT-PIC  ide2, ide3
 14:         16          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:          0
ERR:          0
After upgrading to 2.4.2-pre3 I get sound corruption (I believe this proble=
m has existed since pre2, since I suspect the " - driver sync up with Alan"=
 part of the changes in pre2 to be the source of the problem. I've also tri=
ed 2.4.1-ac9, which gives me the exact same problems (sound corruption, rea=
lly "weird" sound).
Hope this is enough info to at least track down some problem if it hasn't b=
een done already.

I'm not subscribed to the linux kernel mailing-list, so please CC to me any=
 follow-ups and I'll do my best to track down the problem if more info abou=
t my system/configuration is needed.

Best regards,
Ole Andr=E9 Vadla Ravn=E5s

--31522415.981825632005.JavaMail.webmail1@wm-java1.fg.online.no--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
