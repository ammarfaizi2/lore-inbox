Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262200AbREQWmY>; Thu, 17 May 2001 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbREQWmO>; Thu, 17 May 2001 18:42:14 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:52752 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262202AbREQWl6>; Thu, 17 May 2001 18:41:58 -0400
Date: 17 May 2001 23:12:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <811op9uXw-B@khms.westfalen.de>
In-Reply-To: <3B03137A.80221C59@transmeta.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca> <200105162341.f4GNfvT12861@vindaloo.ras.ucalgary.ca> <3B0310A4.87138FB5@transmeta.com> <200105162349.f4GNnSJ13049@vindaloo.ras.ucalgary.ca> <3B03137A.80221C59@transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@transmeta.com (H. Peter Anvin)  wrote on 16.05.01 in <3B03137A.80221C59@transmeta.com>:

> At some point something talks to the device -- in this case, it's the
> SCSI layer.  Follow the interfaces in the kernel and it becomes obvious.

rc = sys_iskind(int filehandle, const char *driverkind)

rc = 0 or Esomething

Think of it as a generalization of isatty(). Maybe

#define isatty(f) sys_iskind(f, "tty")

:-;

MfG Kai
