Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267002AbRGIKOc>; Mon, 9 Jul 2001 06:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267004AbRGIKOW>; Mon, 9 Jul 2001 06:14:22 -0400
Received: from mail.teraport.de ([195.143.8.72]:17024 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S267002AbRGIKOM>;
	Mon, 9 Jul 2001 06:14:12 -0400
Message-ID: <3B4983EF.81C3D8E5@TeraPort.de>
Date: Mon, 09 Jul 2001 12:14:07 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.6.-ac2: Problems with eepro100
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/09/2001 12:13:57 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/09/2001 12:14:04 PM,
	Serialize complete at 07/09/2001 12:14:04 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 after going from 2.4.6-ac1 to 2.4.6-ac2 the eepro100 adapter in my IBM
Thinkpad-570 has stopped working. While "ifconfig" shows the expected
info, nothing network related (ping, yp, bind, amd, ...) is working. In
my config, the eepro driver is built directly into the kernel.

 If I look at the interface lights, it seems that the link goes down
early in the boot sequence. The whole thing is reproducible. When
booting -ac1 again, everything is OK.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
