Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbRGET66>; Thu, 5 Jul 2001 15:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266262AbRGET6r>; Thu, 5 Jul 2001 15:58:47 -0400
Received: from matrix.webzone.net ([205.219.23.25]:35088 "HELO
	matrix.webzone.net") by vger.kernel.org with SMTP
	id <S266259AbRGET6c>; Thu, 5 Jul 2001 15:58:32 -0400
From: "Stephen C Burns" <sburns@farpointer.net>
To: <linux-kernel@vger.kernel.org>
Subject: LILO calling modprobe?
Date: Thu, 5 Jul 2001 14:58:18 -0500
Message-ID: <003201c1058c$d9161d30$4201a8c0@lan.farpointer.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2605
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

Each time I run lilo, I receive the following message in syslog:

modprobe: Can't locate module block-major-3

This machine has no IDE devices.  when I run lilo in verbose mode, I see
that it is querying all possible hard disks in /dev (e.g. Caching device
/dev/hda (0x0300, etc.).  I am, in fact, running an older version of
LILO (0.21) but upgrading when it is not necessary frightens me.  I also
note that calling lilo on a newer machine with newer lilo (21.4) that it
does not query all devices, although that particular machine is all IDE.
I realize that I can alias this block module to off in
/etc/modules.conf, but I wanted to be sure that this is a cosmetic
problem before I brush it off.  Anyone for input?  Thank you!

