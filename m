Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbRAZVON>; Fri, 26 Jan 2001 16:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRAZVOC>; Fri, 26 Jan 2001 16:14:02 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:4814 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130147AbRAZVNx>; Fri, 26 Jan 2001 16:13:53 -0500
Date: Fri, 26 Jan 2001 22:13:36 +0100
From: David Weinehall <tao@acc.umu.se>
To: Stefani Seibold <stefani@seibold.net>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk
Message-ID: <20010126221336.A9040@khan.acc.umu.se>
In-Reply-To: <01012621460200.01354@deepthought.seibold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <01012621460200.01354@deepthought.seibold.net>; from stefani@seibold.net on Fri, Jan 26, 2001 at 09:46:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 09:46:02PM +0100, Stefani Seibold wrote:
> Hi Linus,
> Hi Alan,
> Hi everybody,
> 
> this kernel patch allows to disable all printk messages, by
> overloading the printk function with a dummy printk macro.
> 
> This patch is usefull for embedded systems, where the hardware never
> changes and normaly no textconsole is attachted nor any user will see
> the boot messages. Also, it is nice for rescue disks.
> 
> On my system this saves about 10% of disk- and ramspace.
> 
> For example: My standart desktop kernel is 994834 bytes, without
> printk messages it is only 899664 bytes long. The basic kernel ram
> usage is also 10% less than the same kernel with printk messages.

This could probably be a useful hack, but I suggest you move the
config-option to the "Kernel hacking"-section.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
