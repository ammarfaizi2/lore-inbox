Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313814AbSDIIC7>; Tue, 9 Apr 2002 04:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313815AbSDIIC7>; Tue, 9 Apr 2002 04:02:59 -0400
Received: from [62.245.135.174] ([62.245.135.174]:28326 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313814AbSDIIC5>;
	Tue, 9 Apr 2002 04:02:57 -0400
Message-ID: <3CB2A02C.87B42E9D@TeraPort.de>
Date: Tue, 09 Apr 2002 10:02:52 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Tyan S2462 reboot problems
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/09/2002 10:02:52 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/09/2002 10:02:58 AM,
	Serialize complete at 04/09/2002 10:02:58 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 what (which config option) could be the reason for a reboot hang on a
S2462 (2x1900MP, 2GB, BIOS 2.09) between POST/BIOS and LILO?

 The situation is that I have kernels. One of them hangs said system(s)
reproducible when doing a reboot, that other works fine. When the
systems "hang", they hang before LILO gets started. Just a white block
cursor on the left-upper corner of the screen.

 On cold start or on pressing the reset button both kernels boot fine.
Any ideas? The working  kernel is 2.4.17SMP as shipped by
FujitsuSiemens/Redhat. The bad one is 2.4.18-ac3+trondsNFSstuff. The
config files are not identical. Thats why I ask which of the options
could cause the effect.

TIA
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
