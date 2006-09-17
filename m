Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWIQJnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWIQJnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWIQJnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 05:43:09 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:44959 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964783AbWIQJnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 05:43:07 -0400
Date: Sun, 17 Sep 2006 11:41:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <gregkh@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Industrial device driver uio/uio_*
In-Reply-To: <20060912014341.GB23582@suse.de>
Message-ID: <Pine.LNX.4.61.0609171136190.4473@yvahk01.tjqt.qr>
References: <1157995334.23085.188.camel@localhost.localdomain>
 <Pine.LNX.4.61.0609112121400.19997@yvahk01.tjqt.qr> <20060912014341.GB23582@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hm has this now been named uio? iio may have seem strange to some, but 
>> uio also resembles BSD/Solaris (uio_copyin, uio_copyout, uiomove, etc.)
>
>Yes, I am aware of uio, we have include/linux/uio.h :)
>
>Do you have a better name for this code?  If you don't like uio, I'm
>open to new suggestions.

- I was fine with iio
- udio, for userspace-driven IO (my favorite should iio not make it)
- idd, since it's called "Industrial device driver"
  (don't go about calling it iddqd)

more artistic ones:
- iofu, for IO From Userspace, or, on 2nd thought, simply IO-fu (as in Kung-fu)
- something else that's not related at all? /methinks of squid,
  which, from the name, does not suggest it would be a web proxy.


Jan Engelhardt
-- 
