Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDAIya>; Mon, 1 Apr 2002 03:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311092AbSDAIyV>; Mon, 1 Apr 2002 03:54:21 -0500
Received: from gold.muskoka.com ([216.123.107.5]:62212 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S310979AbSDAIyL>;
	Mon, 1 Apr 2002 03:54:11 -0500
Message-ID: <3CA80BF8.66DCB7E@yahoo.com>
Date: Mon, 01 Apr 2002 00:27:52 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: kbdbook.tmpl
In-Reply-To: <UTC200203312118.VAA468180.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> Spent the past hour or two documenting the keyboard ioctls.

Great!

> Comments are welcome, both about the factual contents
> and about the style and layout. The idea is to eventually
> have all ioctls documented.

Minor nit, but if this is headed for Documentation/ioctl/* or similar,
maybe we can avoid having N copies of the usual GPL boiler plate; one
copy vs. one in each of kbd_ioctl, tty_ioctl, blk_ioctl, etc etc ?

>  This "cooked" mode comes in two flavours: <constant>K_XLATE</constant>,
>  which is the default, and <constant>K_UNICODE</constant> (see below).
+  See also kbd_mode(1).
^^^^^^^^^^^^^^^^^^^^^^^^

I see you haven't added info on all of the KD* ioctl entries - some of 
which I agree aren't really kbd related (e.g. KDMKTONE) - did you forsee
putting these in another file, perhaps with the other vt ioctls?

Paul.
--
main(){int m=19248;if(!fork())for(;;ioctl(0,m,(1<<23)+(rand()&2047)),ioctl
(0,m+2,rand()&7),sleep(1));}/* Hours of entertainment on Linux Console! */

