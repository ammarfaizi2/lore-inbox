Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSGIMtr>; Tue, 9 Jul 2002 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSGIMtq>; Tue, 9 Jul 2002 08:49:46 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62678 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315120AbSGIMtn>; Tue, 9 Jul 2002 08:49:43 -0400
Date: Tue, 9 Jul 2002 14:52:14 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
In-Reply-To: <Pine.SOL.3.96.1020709114618.20865B-100000@libra.cus.cam.ac.uk>
Message-ID: <Pine.SOL.4.30.0207091447560.15575-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Anton Altaparmakov wrote:

> On Tue, 9 Jul 2002, Jens Axboe wrote:
> > I've forward ported the 2.4 IDE core (well 2.4.19-pre10-ac2 to be exact)
> > to 2.5.25. It consists of 7 separate patches:
>
> Fantastic! Seeing that the patches are bitkeeper generated, would it be
> possible for you to make a repository available with the patches? (on
> bkbits perhaps?) Would make it a lot easier for us bitkeeper users just to
> pull from your repository... Especially once you update the patches...

Okay, tired of fantastic ;-)
This forward port has still broken PIO transfer on errors and really
borken multi PIO writes, all due to buffer_head -> bio transition in 2.5.

Jens, you would better spend your time on enhancing block layer to
allow me fixing them cleanly...

Regards
--
Bartlomiej

> Best regards,
>
> 	Anton
> --
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

