Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129840AbQJ1HCk>; Sat, 28 Oct 2000 03:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQJ1HCX>; Sat, 28 Oct 2000 03:02:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13829 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129840AbQJ1HCA>;
	Sat, 28 Oct 2000 03:02:00 -0400
Date: Sat, 28 Oct 2000 00:04:52 -0700
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Hisaaki Shibata <shibata@luky.org>, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001028000452.E3919@suse.de>
In-Reply-To: <20001028141056T.shibata@luky.org> <Pine.LNX.4.10.10010272223240.14599-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27 2000, Andre Hedrick wrote:
> hdparm -r0 /dev/hdc

[snip]

> That is how it is DONE!

This is not necessary, the ide-cd driver will set the read-only
flag appropriately depending on the device type detected.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
