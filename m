Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUHGRUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUHGRUG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUHGRUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:20:06 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:13050 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S263740AbUHGRTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:19:51 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Frediano Ziglio <freddyz77@tin.it>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
References: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1091899191.4254.19.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 07 Aug 2004 19:19:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il sab, 2004-08-07 alle 14:17, Joerg Schilling ha scritto:
> >From: Martin Mares <mj@ucw.cz>
> 
> >> It seems that you are not really interested to understand how it works :-(
> 
> >I am interested, but I life is too short to read the full docs of all existing
> >OS's. Can you give me at least a pointer to the relevant section?
> 
> I already did! ---> "man path_to_inst"
> 

... omissis ...

Could we start again this thread in a less polemical way ??

>From my point of view there are two problems:
1- linux device naming
2- linux cd-rom problems (real or not)

1- My experience with unices it's not so long however taking a HP-UX
course I liked very much having tools to scan for new hardware and a
unique device identification numbering however I don't understand why a
single device should have many different devices based on behavior (like
scd0/sg0, raw/not raw, video0/audio for a grabber and so on). A friend
of mine (not a Linux guru but a simple user) simply said "why there are
so many files in /dev ?"

2- since we all use cdrecord (and/or its library) to burn CDs under
Linux if cdrecord do not works under Linux users (me too) thinks that
Linux do not support well cd-burning. So scgcheck has to work. There are
also some recent mail on LKML about cd-burning problems (with firewire
and usb) so there are some problems... I experience "no error" errors
too (so I can confirm it's a real problem).

freddy77


