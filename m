Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbQJ1HwG>; Sat, 28 Oct 2000 03:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131104AbQJ1Hv5>; Sat, 28 Oct 2000 03:51:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20485 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131051AbQJ1Hvu>;
	Sat, 28 Oct 2000 03:51:50 -0400
Date: Sat, 28 Oct 2000 00:54:49 -0700
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Hisaaki Shibata <shibata@luky.org>, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001028005449.F3919@suse.de>
In-Reply-To: <20001028000452.E3919@suse.de> <Pine.LNX.4.10.10010280042090.14599-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10010280042090.14599-100000@master.linux-ide.org>; from andre@linux-ide.org on Sat, Oct 28, 2000 at 12:43:27AM -0700
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2000, Andre Hedrick wrote:
> > This is not necessary, the ide-cd driver will set the read-only
> > flag appropriately depending on the device type detected.
> 
> This may not be the best option as the default.
> If a dvd-ram is used for backup you may not always want it in RW mode.
> Just a thought.

Just mount it ro then?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
