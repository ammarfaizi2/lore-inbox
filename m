Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132541AbRDATpX>; Sun, 1 Apr 2001 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRDATpO>; Sun, 1 Apr 2001 15:45:14 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:14864 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132549AbRDATpG>;
	Sun, 1 Apr 2001 15:45:06 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104011943.f31JhqL136501@saturn.cs.uml.edu>
Subject: Re: bug database braindump from the kernel summit
To: lm@bitmover.com (Larry McVoy)
Date: Sun, 1 Apr 2001 15:43:52 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104011754.KAA20725@work.bitmover.com> from "Larry McVoy" at Apr 01, 2001 10:54:40 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem details
>     Bug report quality
>     	There was lots of discussion on this.  The main agreement was that we
> 	wanted the bug reporting system to dig out as much info as possible
> 	and prefill that.  There was a lot of discussion about possible tools
> 	that would dig out the /proc/pci info; there was discussion about
> 	Andre's tools which can tell you if you can write your disk; someone
> 	else had something similar.
> 
> 	But the main thing was to extract all the info we could
> 	automatically.	One thing was the machine config (hardware and
> 	at least kernel version).  The other thing was extract any oops
> 	messages and get a stack traceback.

I'm really sick of being buried in useless information. The signal
gets lost in the noise. It is easy to discard automatically generated
bug reports, and way too annoying to wade through the crud.

When network connections hang, the console-tools package version
isn't likely to be of any use. When ramfs leaks memory, nobody needs
the content of /proc/pci.

Sometimes the bit of crud are HUGE. Imagine the hardware info
for a 64-way SGI or Sun box with plenty of devices attached.

