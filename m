Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbSL3Xd5>; Mon, 30 Dec 2002 18:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbSL3Xd5>; Mon, 30 Dec 2002 18:33:57 -0500
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:8379 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S266930AbSL3Xd4>; Mon, 30 Dec 2002 18:33:56 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.52] NFS works with 2.4.20, not with Win2K/SFU
Date: Mon, 30 Dec 2002 18:42:23 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJMEMPDOAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3E10D58F.6010105@pacbell.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heck if I know whose bug this is...

One of my systems runs kernel 2.5.52; its NFS shares mount fine with my
2.4.20 system, and the 2.4.20 shares mount properly on the 2.5.52 system.
All's happy in Linuxland.

Unfortunately, Windows is *not* happy. My system using Windows 2000
w/"Services for Unix" can mount the NFS exports from the 2.4.20 machine --
but while the Win2K box can *see* the 2.5.52 shares, it suffers terribly
when trying to mount them -- sometimes locking up, sometimes telling me the
share can't be found.

Another oddity: The Win2k machine sees the 2.4.20 system by IP address, and
the 2.5.52 system by name.

I have the 2.5.52 kernel compiled for NFS4. Both the 2.5.52 system and
2.4.20 have identical /etc/exports and /etc/hosts.

I'm quite willing to lay this in the lap of those jolly folk in Redmond, but
I was wondering if anyone knew of incompatibility between 2.5.52 NFS and
Win2K/SFU.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions,  http://www.coyotegulch.com
No ads -- just very free (and somewhat unusual) code.

