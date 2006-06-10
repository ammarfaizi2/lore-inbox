Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWFJT0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWFJT0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWFJT0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:26:46 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:16020 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751666AbWFJT0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:26:45 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: PS/2 vs IDE problem on Athlon64 X2
Date: Sat, 10 Jun 2006 21:27:11 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606102127.11400.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a machnine with Athlon64 X2 and AsRock 939Dual-SATA2 mobo (based
on the ULI chipset) on which the PS/2 devices (keyboard and mouse) are in a
bad correlation with IDE, or at least with the LiteOn DVD burner attached to it.

Namely, when the DVD drive is being used (eg. for burning a DVD in the
background) the keyboard and mouse get a bit flaky.  The mouse/keyboard
response gets noticeably worse, some random key codes are generated and
the mouse sometimes behaves as though a button was pressed (this happens
when I move the mouse without touching the buttons).

I've been observing these symptoms for quite some time, at least with all of
the recent -rc kernels, up to and including 2.6.17-rc6.  Of course I can live
with them and they seem to be related to the hardware, but I thought it might
be a good idea to let you know.

I wonder if anyone has observed similar symptoms recently.

Also, if anyone's interested in more detailed information about the system,
please tell me.

Greetings,
Rafael
