Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQJ2VzX>; Sun, 29 Oct 2000 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbQJ2VzN>; Sun, 29 Oct 2000 16:55:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60173 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129308AbQJ2Vyz>;
	Sun, 29 Oct 2000 16:54:55 -0500
Date: Sun, 29 Oct 2000 14:12:14 -0800
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001029141214.B615@suse.de>
In-Reply-To: <20001028134056.J3919@suse.de> <20001029120703Y.shibata@luky.org> <20001028201047.A5879@suse.de> <20001029134145N.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029134145N.shibata@luky.org>; from shibata@luky.org on Sun, Oct 29, 2000 at 01:41:45PM +0900
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29 2000, Hisaaki Shibata wrote:
> I tried the patch.
> But kernel said Oops both fdisk /dev/hdc and
> dd if=/dev/zero of=/dev/hdc bs=2048 count=1 .

> After showing above strace message in a few seconds, kernel panic happened.
> 
> I can not see some head line of Oops messages. Sorry.

Is there any way for you to grab those messages, maybe with a serial
console? I'd really like to see them.

> Please let me test more patches. I will keep up with you.

Or you could try the 2.4 version, as I said originally the 2.2 patch
hasn't been tested at all. It would be nice to know if that works
for you, as I may have screwed up the backport a bit.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
