Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131636AbRAaRv3>; Wed, 31 Jan 2001 12:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130880AbRAaRvT>; Wed, 31 Jan 2001 12:51:19 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:6411 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S132293AbRAaRvC>;
	Wed, 31 Jan 2001 12:51:02 -0500
Date: Wed, 31 Jan 2001 09:49:29 -0800
From: alex@foogod.com
To: Stephen Wille Padnos <stephenwp@adelphia.net>
Cc: Byron Stanoszek <gandalf@winds.org>,
        "David D.W. Downey" <pgpkeys@hislinuxbox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686X
Message-ID: <20010131094929.B16787@draco.foogod.com>
In-Reply-To: <Pine.LNX.4.21.0101311148560.20840-100000@winds.org> <3A7847B1.C8ABDDE1@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A7847B1.C8ABDDE1@adelphia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 12:13:21PM -0500, Stephen Wille Padnos wrote:
> Even though the motherboard *should* perform the same regardless of the amount
> of RAM, it may not.  Physically, the refresh needs higher current drive when
> there are more modules.  I have seen a BIOS option to set the DRAM refresh
> current (RAS, CAS settable to 10 or 16 mA each), but that was only on one
> motherboard that I can remember - you might want to check for this.

It should also be noted that there are several motherboards out there that 
claim to support 1GB or more of RAM which just plain don't, causing problems 
like this because the design is inadequate for the power requirements of that 
many chips (I have, unfortunately, had to work with some of these).  Sometimes 
you can work around it using different types of RAM (buffered vs. unbuffered, 
etc) but even this is iffy and not something I'd rely on for anything too 
important.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
