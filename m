Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265281AbRF0Gkm>; Wed, 27 Jun 2001 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265283AbRF0Gkc>; Wed, 27 Jun 2001 02:40:32 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:2064 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265279AbRF0GkS>; Wed, 27 Jun 2001 02:40:18 -0400
Date: 27 Jun 2001 08:35:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <83fdxMUHw-B@khms.westfalen.de>
In-Reply-To: <E15F4tx-0003sA-00@pmenage-dt.ensim.com>
Subject: Re: [PATCH] User chroot
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0106262138370.18037-100000@weyl.math.psu.edu> <E15F4tx-0003sA-00@pmenage-dt.ensim.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmenage@ensim.com (Paul Menage)  wrote on 26.06.01 in <E15F4tx-0003sA-00@pmenage-dt.ensim.com>:

> >You need to be root to do mknod. You need to do mknod to create /dev/zero.
> >You need /dev/zero to get anywhere near the normal behaviour of the system.
> >
>
> Sure, but we're not necessarily looking for a system that behaves
> normally in all aspects. The example given was that of a paranoid
> network server that does all its initialisation in a normal environment,
> and then does a chroot to its data directory. Or alternatively, forks
> after accepting a connection, and the child does a chroot. No need to be
> able to exec other programs, etc. Such a daemon is certainly possible,
> as I've written one myself. But it had to be started by root, rather
> than by a normal user.

Aah - in that case, it seems the absence of /dev/zero might even be an  
advantage, making it impossible to exec (most) programs.


MfG Kai
