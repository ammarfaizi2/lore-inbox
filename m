Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130530AbQL0Bwo>; Tue, 26 Dec 2000 20:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131075AbQL0Bwe>; Tue, 26 Dec 2000 20:52:34 -0500
Received: from [216.161.55.93] ([216.161.55.93]:52719 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130530AbQL0BwW>;
	Tue, 26 Dec 2000 20:52:22 -0500
Date: Tue, 26 Dec 2000 17:22:57 -0800
From: Greg KH <greg@wirex.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: USB related crashes
Message-ID: <20001226172257.G30876@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3A4930FA.7C8E9F7C@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4930FA.7C8E9F7C@denise.shiny.it>; from pochini@denise.shiny.it on Tue, Dec 26, 2000 at 06:59:54PM -0500
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2000 at 06:59:54PM -0500, Giuliano Pochini wrote:
> 
> How to crash kernel 2.2.17-18:
> 
> Turn on the USB printer without paper and try
> to print something. Wait for the "printer.c: usblp0:
> out of paper" message and turn off the printer.
> Ok, now "killall gs" will freeze the system.
> 
> (kernel 2.2.17-18, I did't try 2.4, GCC 2.95.3, PowerPC750)

What USB code does 2.2.17-18 have in it?  Is this a vendor specific
backport?

Anyway, try 2.2.18 and/or 2.4.0-test13-pre4 and let me / the list know
if you still have this same problem.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
