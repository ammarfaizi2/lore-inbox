Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268221AbRGWNRB>; Mon, 23 Jul 2001 09:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268220AbRGWNQu>; Mon, 23 Jul 2001 09:16:50 -0400
Received: from icebox.org ([205.198.11.50]:48141 "EHLO snowman.icebox.org")
	by vger.kernel.org with ESMTP id <S268219AbRGWNQg>;
	Mon, 23 Jul 2001 09:16:36 -0400
Date: Mon, 23 Jul 2001 08:16:28 -0500 (CDT)
From: gjerdelist@icebox.org
To: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 2100S and 2.4.7-pre8(and 2.4.6-ac5)  i2o driver
In-Reply-To: <20010721150718.A2638@zed.dlitz.net>
Message-ID: <Pine.LNX.4.33L2.0107230612420.11081-100000@snowman.icebox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 21 Jul 2001, Dwayne C. Litzenberger wrote:
> On Thu, Jul 19, 2001 at 01:23:40PM +0200, Ole Gjerde wrote:
> > I've been trying to get this Adaptec 2100S RAID card to work.  It works fine
> > with the adaptec patch(the dpt_i2o driver), but I would really like to get
> > it to work with the stock i2o driver.  According to the messages I've seen

> Are you using i2o_block or i2o_scsi?  i2o_scsi is broken, but some people
> have gotten i2o_block to work.

I had both compiled into the kernel at the time, but i2o_block seems to
initialize first(i2o_block help claims they can both be used at same
time, I sure don't know :).

However, today I tried with only i2o_block compiled in, and now it just
complains about not being able to mount root filesystem.  Same kernel and
same config, except DPT patch(from http://aurore.net/source/, for 2.4.5
but patches without any fuzz) and remove i2o support and add Adaptec i2o
support, works fine.

Thanks,
Ole Gjerde


