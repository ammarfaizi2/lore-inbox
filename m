Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264837AbRGNTPM>; Sat, 14 Jul 2001 15:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264841AbRGNTOw>; Sat, 14 Jul 2001 15:14:52 -0400
Received: from smtp7vepub.gte.net ([206.46.170.28]:25680 "EHLO
	smtp7ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S264837AbRGNTOn>; Sat, 14 Jul 2001 15:14:43 -0400
From: aset@bellatlantic.com
Message-ID: <3B509CA6.6E7EE91@bellatlantic.com>
Date: Sat, 14 Jul 2001 15:25:31 -0400
X-Mailer: Mozilla 4.77 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux USB boot hang
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I compiled and installed Linux-2.4.5smp on a dual 300 MHz Pentium II
running Red Hat 7.0 with gcc 2.96. The motherboard has two sets of USB
headers but there are no USB ports. If I configure the kernel with USB
modules, at boot linux complains repeatedly:

    hub.c: Cannot  enable port 1 of hub 1, disabling port.
    hub.c: Maybe USB cable is bad?
    hub.c: Cannot enable port 2 of hub 1, disabling port.
    hub.c: Maybe USB cable is bad?

 I don't know how to get out of this, so I just wait for it to time out
to finish booting. If I don't configure the kernel for a USB controller
then the during the boot process it complains that it can't find the
usb-uhci module and the boot process hangs at sendmail. Again I wait for
the time-out for the boot process to finish.  How do I fix this dilemma.
Is there some way I can modifiy hub.c to stop looking for ports 1 and 2?

Thanks, from a Linux newbie.

Don Werder
aset@bellatlantic.net

