Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbTC1AKb>; Thu, 27 Mar 2003 19:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTC1AKb>; Thu, 27 Mar 2003 19:10:31 -0500
Received: from [81.2.110.254] ([81.2.110.254]:6905 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261630AbTC1AKa>;
	Thu, 27 Mar 2003 19:10:30 -0500
Subject: Re: [PATCH] IDE 2.5.66-masked_irq-fix-A0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303280052480.6453-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303280052480.6453-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048810944.3953.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 00:22:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 23:54, Bartlomiej Zolnierkiewicz wrote:
> # Revert previous masked_irq handling for ide_do_request().
> # Fixes "hda: lost interrupt" bug.

Rejected. Breaks hardware where someone put IDE on IRQ0, the
logic is sound enough and I will fix it properly using the NO_IRQ
stuff

