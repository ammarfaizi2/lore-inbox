Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJMBP1>; Sat, 12 Oct 2002 21:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbSJMBP1>; Sat, 12 Oct 2002 21:15:27 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:11780 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261395AbSJMBP0>;
	Sat, 12 Oct 2002 21:15:26 -0400
Date: Sat, 12 Oct 2002 18:16:44 -0700
From: Greg KH <greg@kroah.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-pre10: make PL-2303 hack work again
Message-ID: <20021013011644.GA12720@kroah.com>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net> <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 05:42:49PM -0700, Barry K. Nathan wrote:
> The following patch allows the PL-2303 hack to work again. It applies
> to and has been tested with 2.4.20-pre10. Testing included using an ISDN
> "modem" connected to the PL-2303 to do some web browsing and some
> downloads (including a gzipped Linux 2.5.42 tarball).
> 
> The patch resurrects a sanity check (or so it appears to me) which was
> removed in 2.4.20-pre2. However, the new version of the check is
> contained within the PL-2303 hack #ifdef's, and it no longer relies on
> variables like interrupt_pipe which have been removed from the USB
> serial code.
> 
> Given that 2.4.19 works with my PL-2303 and 2.4 is supposed to be a
> "stable" series, I'd appreciate if this patch (or another which fixes my
> problem) could be merged. If this patch needs improvements first, please
> let me know.

Sweet, nice job, I like it.  I'll go add this to my kernel trees and
send it to Marcelo.

Thanks for finding and fixing this.

Now, would you mind taking a look at 2.5, and fixing this there too? :)

thanks,

greg k-h
