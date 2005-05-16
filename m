Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVEPOyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEPOyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEPOwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:52:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49375 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261673AbVEPOwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:52:04 -0400
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Tomasz Torcz <zdzichu@irc.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <20050513211609.75216bf8.diegocg@gmail.com>
	 <20050515095446.GE68736@muc.de>
	 <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
	 <20050515141207.GB94354@muc.de> <20050515145241.GA5627@irc.pl>
	 <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116255017.21358.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 15:50:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-05-15 at 16:00, Mikulas Patocka wrote:
> There are rumors that some disks ignore FLUSH CACHE command just to get
> higher benchmarks in Windows. But I haven't heart of any proof. Does
> anybody know, what companies fake this command?

The specification was intentionally written so that his command has to
do what it is specified to or be unknown and thus error and not be in
the ident info.

That was done by people who wanted to be very sure that any vendor who
tried to shortcut the command would have "sue me" written on their
forehead.

There are problems with a few older drives which have a write cache but
don't support cache commands.

Alan

