Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTH2Ul0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTH2Ul0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:41:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:38790 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262161AbTH2UkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:40:16 -0400
Date: Fri, 29 Aug 2003 13:40:17 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
Message-ID: <20030829204017.GA2580@kroah.com>
References: <pV54.523.43@gated-at.bofh.it> <pX6U.7Vu.35@gated-at.bofh.it> <200308292032.h7TKWats006188@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308292032.h7TKWats006188@post.webmailer.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 10:31:47PM +0200, Arnd Bergmann wrote:
> OGAWA Hirofumi wrote:
> 
> > Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?
> 
> Right. Actually, all uses of DEVICE_ID_SIZE in drivers/s390 are wrong.
> I'll take care of that.
> 
> The only other user of DEVICE_ID_SIZE right now is drivers/usb/core/file.c
> and I'm not sure if it's used in the intended way there.
> Greg, maybe you want to get rid of it as well, or move the definition
> into file.c.

I'm deleting it right now... :)

thanks,

greg k-h
