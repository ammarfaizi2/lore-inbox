Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTGXQwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271716AbTGXQwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:52:09 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:35820 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269451AbTGXQwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:52:07 -0400
Date: Thu, 24 Jul 2003 13:05:42 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: some kernel config menu suggested tweaks
Message-ID: <Pine.LNX.4.53.0307241256430.20528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  from my experimenting with 2.6.0-test1-bk2:


1) i mentioned this before, i think, but after one deselects
   Power management, should ACPI Support and CPU Frequency
   scaling still be available?

   the "make xconfig" menu display suggests a submenu 
   structure there, which clearly isn't the case.


2) can all of the low-level SCSI drivers be made deselectable
   in one swell foop?  folks might want SCSI support just for
   generic support and SCSI (ide-scsi) emulation, but have no
   interest in low level SCSI drivers.

   so it would be convenient to be able to select the generic
   support, and yet not have to deselect low-level drivers
   and PCMCIA SCSI adapter support painfully, one at a time.

3) can all of ATM support be deselected with a single click?
   in the same way "PCMCIA network device support" is done just
   above it under "Networking options"?

rday
