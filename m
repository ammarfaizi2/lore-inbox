Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbTC1ANv>; Thu, 27 Mar 2003 19:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbTC1ANu>; Thu, 27 Mar 2003 19:13:50 -0500
Received: from [81.2.110.254] ([81.2.110.254]:7417 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261808AbTC1ANt>;
	Thu, 27 Mar 2003 19:13:49 -0500
Subject: Re: [PATCH] new IDE PIO handlers 4/4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303280056440.6453-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303280056440.6453-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048811150.3952.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 00:25:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 23:57, Bartlomiej Zolnierkiewicz wrote:
> # Rewritten PIO handlers, both single and multiple sector sizes.
> #
> # They make use of new bio travelsing code and are supposed to be
> # correct in respect to ATA state machine.
> #
> # Patch 4/4 - Remove not taskfile PIO handlers from ide-disk.c.
> #	      Also remove not taskfile do_rw_disk().
> #
> # Now only new PIO handlers and taskfile based do_rw_disk() are used.

Looks good once the new stuff is tested for a few releases

