Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRBOTAz>; Thu, 15 Feb 2001 14:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRBOTAp>; Thu, 15 Feb 2001 14:00:45 -0500
Received: from dweeb.lbl.gov ([128.3.1.28]:35090 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S129164AbRBOTAc>;
	Thu, 15 Feb 2001 14:00:32 -0500
Message-ID: <3A8C2696.797697D8@lbl.gov>
Date: Thu, 15 Feb 2001 10:57:26 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-RAID i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: hard lockup using 2.4.1ac-1, usb, uhci
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, just found this one out.

I've got a sony vaio 505tx, running linux-2.4.1-ac1, and I've got all
the good stuff turned.

With APM turned, and using USB uhci-alt driver (all as modules), if you
put the laptop to sleep with any (and I mean *any*) usb devices plugged
in, it will hard lock upon resume.

Only way out is to power cycle the poor thing..

I'm going to update to a newer version of the kernel, and see if the
other uhci driver suffers from this fate..

-- 
------------------------+--------------------------------------------------
Thomas Davis		| PDSF Project Leader
tadavis@lbl.gov		| 
(510) 486-4524		| "Only a petabyte of data this year?"
