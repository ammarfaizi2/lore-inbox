Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132294AbRAUAnL>; Sat, 20 Jan 2001 19:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132440AbRAUAnC>; Sat, 20 Jan 2001 19:43:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64008 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132294AbRAUAmx>;
	Sat, 20 Jan 2001 19:42:53 -0500
Date: Sun, 21 Jan 2001 01:42:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Minors remaining in Major 10 ??
Message-ID: <20010121014221.A5792@suse.de>
In-Reply-To: <3A6A1B40.459A1B7@transmeta.com> <Pine.LNX.4.10.10101201521320.657-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101201521320.657-100000@master.linux-ide.org>; from andre@linux-ide.org on Sat, Jan 20, 2001 at 03:40:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20 2001, Andre Hedrick wrote:
> The idea is to have a char not a block because there is no buffered access
> to the dummy driver.  It is very painful to have to open one block device
> and pass parameters to select the one you really want to service in a
> passive mode.

Like the raw devices we have already?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
