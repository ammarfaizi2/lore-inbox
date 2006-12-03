Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935809AbWLCLG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935809AbWLCLG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935814AbWLCLG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:06:29 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:35548 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S935809AbWLCLG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:06:28 -0500
Date: Sun, 3 Dec 2006 12:04:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <w@1wt.eu>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
In-Reply-To: <20061203083031.GB900@1wt.eu>
Message-ID: <Pine.LNX.4.61.0612031202250.25553@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com> <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
 <20061202211522.GB24090@1wt.eu> <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr>
 <20061202225528.GA27342@1wt.eu> <1165113438.5698.5.camel@lade.trondhjem.org>
 <20061203060208.GA900@1wt.eu> <1165129510.5745.14.camel@lade.trondhjem.org>
 <20061203083031.GB900@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It's one use, but another one is for diskless terminals, often built
>from old systems. In this case, it's to avoid the cost, noise, power
>consumption and failures associated to disks. It's quite often done
>one radically different archs/OS between the server and the clients,
>making the upgrade more complicated.

unionfs is becoming popular, and it's one of those things that can't
do without initramfs at all, for example.

>> I have no influence over the distributions' choice of kernel compiler
>> options. The fact is, though, that few of them support nfsroot out of
>> the box. AFAICS FC-6 is one of those that appears not to.

(File a bug report, heh.)

So what, noone supports unionfs OOTB, which leaves me with what options?
Right, hacking it up myself by modifying the initramfs scripts my
distro's mkinitrd gave me.


	-`J'
-- 
