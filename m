Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTIZMxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTIZMxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:53:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49058 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262175AbTIZMxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:53:49 -0400
Date: Fri, 26 Sep 2003 14:53:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeffrey Forman <jforman@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord burn looks fine, but upon mounting, i get nothing.
Message-ID: <20030926125350.GD15415@suse.de>
References: <1064554552.6661.6.camel@tribeca.formanonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064554552.6661.6.camel@tribeca.formanonline.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26 2003, Jeffrey Forman wrote:
> i am having some issues burning cd's using cdrecord in 2.6.0-test5-mm4,
> and possibly could get someone to lend a hand, since i'm not sure if
> its a kernel issue or a cdrecord issue.
> 
> i am running 2.6.0-test5-mm4, on a p4-2.8/512MB machine. i have an atapi
> plextor 48/24/48A ide cd burner.i am trying to burn various data, iso's
> etc. cdrecord seems to burn correctly (paste of output below), but upon
> trying to mount the burned cd, it shows up as 0 files on the cd. i am
> using atapi burning with the command line: cdrecord dev=/dev/hdc -v
> driveropts=burnfree speed=30 pentium4-1.4-20030911-cd1.iso. this
> pentium4.iso is a gentoo release of its install. it is a 501MB file, but
> when mounted, i see
> 
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/cdroms/cdrom0    246M  246M     0 100% /mnt/cdrom

[snip]

Just to keep the list uptodate (Jeffrey wrote me off list too and I
answered that before seeing this one) - it appears to be a dma problem,
it burns correctly with pio. I'll post a resolution here once one is
found.

-- 
Jens Axboe

