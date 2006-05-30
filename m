Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWE3KWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWE3KWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWE3KWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:22:31 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:59107 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932229AbWE3KWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:22:30 -0400
Message-ID: <01a801c683d2$e7a79c10$1800a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs>
Subject: Re: How to send a break? - dump from frozen 64bit linux
Date: Tue, 30 May 2006 12:22:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cut]

>
> >
> > 2) You should try the latest stable kernel. Currently that's 2.6.16.18
> > (http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.18.tar.bz2).
> > There have been lots of fixes added since 2.6.15.x and perhaps you are
> > lucky that whatever is giving you trouble  has already been fixed in
> > that kernel.
>

This time i try the 2.6.16.18 kernel, but the issue is the same!

Here is the logs:
http://download.netcenter.hu/bughunt/20060530/dump.txt  (The frozen system,
540KB)
http://download.netcenter.hu/bughunt/20060530/261618-good.txt  (After
reboot, the working system, 300KB, uptime 54 min)
http://download.netcenter.hu/bughunt/20060530/dmesg.txt  (The boot dmesg
file)

Can somebody tell me, whats wrong?

It seems like some part of the fs died.
(The "top", "watch df" hangs on the ssh window, in the "mc" the line is
moving, but if i try to step in/out from/to dir, it hangs too, ping reply is
working. )

I use only 3 fs:
- the root FS on NFS.
- one XFS mount point from sata drive (200GB)
- one huge XFS mount point from NBD. (14TB)

Cheers,
Janos

