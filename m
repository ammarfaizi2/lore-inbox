Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbRGIBhX>; Sun, 8 Jul 2001 21:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbRGIBhC>; Sun, 8 Jul 2001 21:37:02 -0400
Received: from mail.tbdnetworks.com ([64.36.152.146]:22462 "EHLO
	mu.tbdnetworks.com") by vger.kernel.org with ESMTP
	id <S266952AbRGIBgz>; Sun, 8 Jul 2001 21:36:55 -0400
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15177.2338.86751.734801@gargle.gargle.HOWL>
Date: Sun, 8 Jul 2001 18:30:10 -0700
To: linux-kernel@vger.kernel.org
Subject: loosing interrupt 12 under Linux-2.4.[2-6]
X-Mailer: VM 6.92 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm having problems with my mouse (touchpad w/ 2 buttons) under
Linux-2.4.6 on my old Compaq Armada 4131T notebook.  After booting,
the mouse interrupt is shown in /proc/interrupts and everything is
working fine (i.e. gpm -t ps2 works fine).  However, after some time
(normally about 10k interrupts), the mouse is stuck.  Restarting gpm
fixes this (i.e. the mouse works again), but only for a couple of
times.  Then, the interrupt 12 is no longer displayed when running cat
/proc/interrupts and gpm always complains about "Keyboard: Timeout -
AT keyboard not present?".

I had the same problem under 2.4.2 and 2.4.5.  However 2.2.x worked
fine (about 6 month ago; haven't used the laptop for a while and
during upgrade to RH-7.1 accidentically removed the old installation,
so there is curently no 2.2 kernel).

Sometimes, Linux won't recognize the mouse even on startup (i.e. no
interrupt 12 at all).  Rebooting fixes this normally.

Any ideas?

--nk

