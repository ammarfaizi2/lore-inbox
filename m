Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264758AbUDWIW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264758AbUDWIW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUDWIW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:22:56 -0400
Received: from web13904.mail.yahoo.com ([216.136.175.67]:10767 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264758AbUDWIWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:22:39 -0400
Message-ID: <20040423082238.77374.qmail@web13904.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Fri, 23 Apr 2004 01:22:38 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Two problems after upgrade tto 2.4.26
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >b)) Before the upgrade the notebook fan was rarely running at full
>> >speed. AAnd if, only forr short ttimes. Now it kicks in frequeently
>> and
>> >for up to 15 minutes.
>> >
>
>Does /proc/interrupts show any acpi events?
>Did it in 2.4.23?
>
Len,

 when booting without "acpi=off" it shows indeed some ACPI Interrupts:

cat /proc/interrupts
           CPU0
  0:      31464          XT-PIC  timer
  1:        570          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          5          XT-PIC  HiSax
  8:          2          XT-PIC  rtc
  9:       1197          XT-PIC  acpi
 10:       1695          XT-PIC  eth0, usb-uhci, Texas Instruments
 PCI1420, Texas Instruments PCI1420 (#2)
 12:       5460          XT-PIC  PS/2 Mouse
 14:      18052          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:          0
ERR:          0

 When booting with "acpi=off", as well as with 2.4.23 it shown no acpi
interrupts (not really surprising).

Martin


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
