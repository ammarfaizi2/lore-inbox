Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278329AbRJSHt7>; Fri, 19 Oct 2001 03:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278330AbRJSHtt>; Fri, 19 Oct 2001 03:49:49 -0400
Received: from denise.shiny.it ([194.20.232.1]:28621 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S278329AbRJSHte>;
	Fri, 19 Oct 2001 03:49:34 -0400
Message-ID: <XFMail.20011019095006.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011018194415.S12055@athlon.random>
Date: Fri, 19 Oct 2001 09:50:06 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
Cc: Andrea Arcangeli <andrea@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Indeed, only 2.2 trusted the check media change information and left the
> cache valid on top of the floppy across close/open of the blkdev.

Which is not a bad thing IMHO, but it can cause problems with
some broken SCSI implementation where the drive doesn't send
UNIT_ATTENTION after a media change (like my MO drive when I
misconfigured the jumpers, damn :-((( ).


Bye.

