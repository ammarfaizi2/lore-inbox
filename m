Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265648AbUFCQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUFCQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbUFCQR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:17:57 -0400
Received: from bromo.msbb.uc.edu ([129.137.3.146]:21424 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S265715AbUFCQRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:17:47 -0400
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.6 and keyboard freezes
Message-Id: <20040603161748.141C61DC040@bromo.msbb.uc.edu>
Date: Thu,  3 Jun 2004 12:17:48 -0400 (EDT)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Is anyone else seeing this behavior? On Fedora Core 2 using the
their kernel-smp-2.6.6-1.403 and kernel-smp-2.6.6-1.406 kernels I 
am seeing a problem with a PS/2 Logitech keyboard becoming
non-functional after overnight. In particular the keyboard is
initially usable after the machine is woken the next morning
under X windows. Shortly afterwards (~15 minutes) the keyboard
stops responding. The PS/2 mouse still works however and one
can log out of the X windows session to restart the X server.
This however doesn't bring back the keyboard. Also unplugging
and replugging the keyboard doesn't help. Only a full reboot
will restore the keyboard to working condition. There is no
errors appearing in /var/log/messages that indicate any 
errors related to the keyboard. I have heard from at least
one other Fedora user who has seen the same thing under Core 2.
Is this perhaps related to acpi somehow and how can I work
around it since rebooting everyday is unacceptable.
                        Jack Howarth
