Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbQJ1HpQ>; Sat, 28 Oct 2000 03:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131051AbQJ1HpF>; Sat, 28 Oct 2000 03:45:05 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:30724
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130113AbQJ1HpB>; Sat, 28 Oct 2000 03:45:01 -0400
Date: Sat, 28 Oct 2000 00:43:27 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Hisaaki Shibata <shibata@luky.org>, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001028000452.E3919@suse.de>
Message-ID: <Pine.LNX.4.10.10010280042090.14599-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000, Jens Axboe wrote:

> This is not necessary, the ide-cd driver will set the read-only
> flag appropriately depending on the device type detected.

This may not be the best option as the default.
If a dvd-ram is used for backup you may not always want it in RW mode.
Just a thought.

Andre Hedrick
The Linux ATA/IDE guy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
