Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315206AbSDWNvQ>; Tue, 23 Apr 2002 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315211AbSDWNvP>; Tue, 23 Apr 2002 09:51:15 -0400
Received: from [62.245.135.174] ([62.245.135.174]:39081 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S315206AbSDWNvP>;
	Tue, 23 Apr 2002 09:51:15 -0400
Message-ID: <3CC566CC.4734B81B@TeraPort.de>
Date: Tue, 23 Apr 2002 15:51:08 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: robert@dell.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reboot=bios is invalidating cache incorrectly
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 03:51:08 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 03:51:14 PM,
	Serialize complete at 04/23/2002 03:51:14 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [PATCH] reboot=bios is invalidating cache incorrectly
> 
> 
> This patch applies cleanly to 2.4.18 and 2.5.8. It probably also works
> with all 2.2.x, 2.4.x and 2.5.x kernels.
> 
> This fixes a long standing bug that prevented reliable reboots on some
> platforms.
> 
Robert,

 care to specify which platforms? :-) I ask because I am experiencing
reboot hangs between BISO and lilo on Tyan 2462 boards. Apparently
others see similar things.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
