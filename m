Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274951AbTHACYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 22:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274953AbTHACYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 22:24:52 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:35456 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S274951AbTHACYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 22:24:51 -0400
Date: Fri, 1 Aug 2003 10:24:48 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Greg KH <greg@kroah.com>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: USB problems encountered when offing Zaurus
Message-ID: <20030801022448.GA3624@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <20030731065200.GA1226@eugeneteo.net> <20030731154815.GB3202@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731154815.GB3202@kroah.com>
X-Operating-System: Linux 2.6.0-test2-mm2-kj1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Greg KH">
> On Thu, Jul 31, 2003 at 02:52:00PM +0800, Eugene Teo wrote:
> > I got this when I try to turn off Zaurus SL-5560.
> > Any idea what went wrong?
> > 
> > I am using 2.6.0-test2-mm2-kj1. I am trying to turn
> > off my Zaurus, and then turn it on again. When I turn
> > it off, I get the following messages. When I turn it
> > on, and try to do a samba mount, i get pretty unstable
> > connection.pretty unstable
> > connection.
> > 
> > Eugene
> > 
> > Jul 31 14:40:27 amaryllis kernel: uhci-hcd 0000:00:1d.0: remove, state 3
> > Jul 31 14:40:27 amaryllis kernel: usb usb1: USB disconnect, address 1
> > Jul 31 14:40:27 amaryllis kernel: Call Trace:
> > Jul 31 14:40:27 amaryllis kernel:  [__might_sleep+95/114] __might_sleep+0x5f/0x72
> 
> Known bug, I have a fix for this in my tree which will get sent to Linus
> in a few days.  The patch for this was posted to the linux-usb-devel
> mailing list last week if it's really bothering you :)

Thanks Greg! I am going to hunt the patch in the mailing list cos it
does bother me hehe :)

Eugene

> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
