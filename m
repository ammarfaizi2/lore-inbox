Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSGHTfH>; Mon, 8 Jul 2002 15:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSGHTfG>; Mon, 8 Jul 2002 15:35:06 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:23262 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314551AbSGHTfG>; Mon, 8 Jul 2002 15:35:06 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200207081937.g68Jbi8t000811@twopit.underworld>
Subject: Scary VM message with Linux 2.4.19-pre9-ac3
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jul 2002 20:37:44 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just seen this message appear in my kernel log:

Jul  8 20:20:44 twopit kernel: do_wp_page: bogus page at address 40fb8000 (page 0xc2f96990)
Jul  8 20:20:44 twopit kernel: VM: killing process setiathome

I am running Linux-2.4.19-pre9-ac3 on a dual 733 MHz PIII, with 1.25
GB RAM, devfs, ALSA-CVS and lm_sensors 2.6.3, and this is the first
time I have *ever* seen this message. To be fair, I've been suspecting
memory corruption in 2.4.18+ kernels for a long time, and this message
did not produce an oops, but I am *particularly* spooked this time
because this it happened (only once) just *minutes* after my first
reboot since an important BIOS upgrade. Normally, the machine stays up
for about a week before it needs a maintenance reboot.

Everything still fine so far ... see that rubik's cube go...

I have previously run memtest-3.0 over all my RAM and it has checked
out.

Should I worry?

Cheers,
Chris
