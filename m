Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRB1SH1>; Wed, 28 Feb 2001 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRB1SHS>; Wed, 28 Feb 2001 13:07:18 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:34319 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129156AbRB1SHI>;
	Wed, 28 Feb 2001 13:07:08 -0500
Date: Wed, 28 Feb 2001 19:07:00 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: RE: Unmounting and ejecting the root fs on shutdown.
To: Per Erik Stendahl <PerErik@onedial.se>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A9D3E44.741319E4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Erik Stendahl wrote :

> What I do know now is how to make the kernel not lock the CD in the
> first place. Simply ioctl(/dev/cdrom, CDROM_CLEAR_OPTIONS, CDO_LOCK)
> from /linuxrc in the initrd. This way I can remove the CD anytime
> I please which is enough for me. And I dont have to patch the kernel.

Or : echo 0 > /proc/sys/dev/cdrom/lock
( I am not sure if this is the right filename )

Or run magicdev ;-)

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
