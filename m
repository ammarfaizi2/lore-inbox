Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318924AbSHSQFl>; Mon, 19 Aug 2002 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318925AbSHSQFl>; Mon, 19 Aug 2002 12:05:41 -0400
Received: from bromo.med.uc.edu ([129.137.3.146]:35847 "HELO bromo.msbb.uc.edu")
	by vger.kernel.org with SMTP id <S318924AbSHSQFl>;
	Mon, 19 Aug 2002 12:05:41 -0400
Date: Mon, 19 Aug 2002 12:09:28 -0400 (EDT)
From: Jack Howarth <howarth@bromo.msbb.uc.edu>
Message-Id: <200208191609.MAA27419@bromo.msbb.uc.edu>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20pre3 breaks alsa 0.9.0.rc3
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I haven't seen this mentioned yet but the new
pre3 changes remove the typedef of urb_t and purb_t
from include/linux/usb.h. This causes alas-drivers
0.9.0rc3 to fail to compile. I wanted to find out
if this removal of urb_t and purb_t was 
final or if it would be regressed back in pre4?
Thanks for any information.
                        Jack
