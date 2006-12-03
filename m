Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757385AbWLCRAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385AbWLCRAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbWLCRAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:00:11 -0500
Received: from pat.uio.no ([129.240.10.15]:36065 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1757385AbWLCRAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:00:10 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Willy Tarreau <w@1wt.eu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061203083031.GB900@1wt.eu>
References: <4571CE06.4040800@popdial.com>
	 <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
	 <20061202211522.GB24090@1wt.eu>
	 <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr>
	 <20061202225528.GA27342@1wt.eu>
	 <1165113438.5698.5.camel@lade.trondhjem.org> <20061203060208.GA900@1wt.eu>
	 <1165129510.5745.14.camel@lade.trondhjem.org> <20061203083031.GB900@1wt.eu>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 11:59:50 -0500
Message-Id: <1165165190.711.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.167, required 12,
	autolearn=disabled, AWL 1.70, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 09:30 +0100, Willy Tarreau wrote:
> It's one use, but another one is for diskless terminals, often built
> from old systems. In this case, it's to avoid the cost, noise, power
> consumption and failures associated to disks. It's quite often done
> one radically different archs/OS between the server and the clients,
> making the upgrade more complicated.

It is naive to believe that the only thing you need to keep up to date
is the kernel itself: if you are at all worried about security, then
upgrades are a fact of life. Depending on your choice of distribution,
then you can make that process easy or difficult.

As for the kernel, nobody has promised you that we would keep all
possible implementations of a given feature around forever. As and when
we develop better ways of implementing a set of features, we may want to
remove the old ways. You will be given advance notice in
Documentation/feature-removal-schedule.txt, and it will be your choice
whether or not you want to follow the upgrade path, or stick with your
existing setup.
What we will not do is to maintain a bunch of parallel kernel trees or
unduly bloat the kernel forever in order to support old systems: that is
the job of those distributions that promise you n years legacy support.

  Trond

