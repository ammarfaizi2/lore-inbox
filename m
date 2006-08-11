Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWHKNSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWHKNSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHKNSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:18:10 -0400
Received: from smtp0.libero.it ([193.70.192.33]:47554 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S1750839AbWHKNSI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:18:08 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: <linux-atm-general@lists.sourceforge.net>, <usbatm@lists.infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: [ATM CLIP][USBATM] Linux 2.6.16(13) to 2.6.17(4) migration problem
Date: Fri, 11 Aug 2006 15:17:37 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDMEOJFLAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dears,

I have a couple of ADSL lines to Internet, connected to two linux boxes through a couple of SpeedTouch 330. One box adopts the Classical IP protocol, while the other the PPPoA one.

Both the internet connections worked fine for month up to the 2.6.16.13 kernel. Now, upgrading to 2.6.17.4, things work fine for few seconds (a minute at most, but timing varies), then the box stops receiving packets. No event is logged, but I didn't manage to turn debugging log on.

When things break, I can see that outgoing packets increse the tx field in /proc/net/atm/speedtch:0, while the rx field gets stuck.

I can't set up a testbed for this, since I need to keep the two boxes running, nor I have handy a further SpeedTouch 330. Actually, I just stepped back the boxes to 2.6.16.13.

However, before looking for another modem and managing to set up a third machine as a testbed, I would like to know if any of you has any experience to share about SpeedTouch or USBATM or ATM troubles with 2.6.17.x.

Regards,

-----------------------------------
Giampaolo Tomassoni - IT Consultant
Piazza VIII Aprile 1948, 4
I-53044 Chiusi (SI) - Italy
Ph: +39-0578-21100

