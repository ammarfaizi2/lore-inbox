Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSKORqn>; Fri, 15 Nov 2002 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSKORqn>; Fri, 15 Nov 2002 12:46:43 -0500
Received: from dhcp80ff2399.dynamic.uiowa.edu ([128.255.35.153]:13696 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S266708AbSKORqk>;
	Fri, 15 Nov 2002 12:46:40 -0500
Date: Fri, 15 Nov 2002 11:53:37 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 - PCMCIA ethernet and wireless ethernet bugs
Message-ID: <20021115175336.GD2828@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot get my two PCMCIA cards to work.  On boot, I get the message:
Nov 14 23:00:15 paulus Linux Kernel Card Services 3.1.22
Nov 14 23:00:15 paulus options:  [pci] [cardbus] [pm]
Nov 14 23:00:15 paulus ds: no socket drivers loaded!

None of the PCMCIA wireless modules seem to work.  In addition, I get the
  following errors when trying to manually load the aironet modules:
/lib/modules/2.5.47/kernel/drivers/net/wireless/airo.o: unresolved symbol wirele
ss_send_event_Rdc9b8ae0
/lib/modules/2.5.47/kernel/drivers/net/wireless/airo.o: insmod /lib/modules/2.5.
47/kernel/drivers/net/wireless/airo.o failed
/lib/modules/2.5.47/kernel/drivers/net/wireless/airo.o: insmod airo_cs failed

Any ideas what might be causing this?  The kernel's pretty sweet; I just
  need networking to work.  It actually fixes a problem I've been having
  with USB in the 2.4 series (get only timeouts when connecting a USB device
  after a reboot).  I'd like to use it full-time, but I need the networking,
  erm, working.
Thanks!

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"[The question of] copy protection has long been answered, and it's only
  a matter of months until more or less all CDs will be published with
  copy protection."  --"Ihr EMI Team" 
    http://www.theregister.co.uk/content/54/27960.html



