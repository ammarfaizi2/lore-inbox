Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbTC0XqI>; Thu, 27 Mar 2003 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbTC0XpW>; Thu, 27 Mar 2003 18:45:22 -0500
Received: from [81.2.110.254] ([81.2.110.254]:6649 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261572AbTC0XpA>;
	Thu, 27 Mar 2003 18:45:00 -0500
Subject: Re: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303280012150.24932-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303280012150.24932-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048809404.3952.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 23:56:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 23:46, Bartlomiej Zolnierkiewicz wrote:
> 2.5.66-ide-pio-1-A0.diff
> 2.5.66-ide-pio-2-A0.diff
> and turn on IDE_TASKFILE_IO config option in IDE menu
> 
> As always with block or IDE changes special care is _strongly_
> recommended, don't blame me if it eats your fs :-).

The IDE taskfile stuff for I/O is known broken. Thats why it
is currently disabled. I plan to keep it that way until 2.7


