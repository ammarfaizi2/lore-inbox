Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279512AbRKFOUO>; Tue, 6 Nov 2001 09:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279467AbRKFOUF>; Tue, 6 Nov 2001 09:20:05 -0500
Received: from barn.holstein.com ([198.134.143.193]:34058 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S279505AbRKFOTx>;
	Tue, 6 Nov 2001 09:19:53 -0500
Date: Tue, 6 Nov 2001 09:19:15 -0500
Message-Id: <200111061419.fA6EJF320636@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.ul
Subject: Lock up under 2.4.14-ac8
Reply-To: troy@holstein.com
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/06/2001 09:19:17 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/06/2001 09:19:18 AM,
	Serialize complete at 11/06/2001 09:19:18 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,
  I've had a disturbing lock up under 2.4.13-ac8, and I'm
sorry, I don't appear to have any oops or log entries to report.

What happens, under moderate load (from memory):

1. ssh to my home machine.
2. compiling wine
3. compiling gcc-2.95.3
4. compiling linux-2.4.14
5. running netscape.
6. Having four or five gnome-terminal windows open and emacs 21.1

The caps lock and scroll lock turn on and the
screen locks up.  The magic sysrq keys still appear to
work, but thats about it.  The problem has never appeared
before.  I'm running 2.4.13-ac7 with as similar a load as possible
and its fine.  The problem is reproducible.  I compiled the
kernel with gcc-2.95.3 having reverted from gcc-3.0.2 because of
the internal compiler errors.  
My hardware is a DELL OptiPlex GX1 with 256Megs of memory.

Anything more you need to know?

Thanks,
Todd
