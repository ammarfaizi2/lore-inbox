Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVAVFFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVAVFFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 00:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAVFFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 00:05:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:11688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262663AbVAVFFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 00:05:41 -0500
Date: Fri, 21 Jan 2005 21:05:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, dev@osdl.org, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net
Subject: Re: [LTP] Re: [Dev] Re: Kernel Panic with LTP on 2.6.11-rc1 (was Re: LTP Results for 2.6.x and 2.4.x)
Message-ID: <20050121210537.L24171@build.pdx.osdl.net>
References: <Pine.LNX.4.33.0501211706430.32650-100000@osdlab.pdx.osdl.net> <Pine.LNX.4.33.0501211838240.32650-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0501211838240.32650-100000@osdlab.pdx.osdl.net>; from bryce@osdl.org on Fri, Jan 21, 2005 at 07:11:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bryce Harrington (bryce@osdl.org) wrote:
> Well, I'm not having much luck.  strace isn't installed on the system
> (and is giving errors when trying to compile it).  Also, the ssh session
> (and sshd) quits whenever I try running the following growfiles command
> manually, so I'm having trouble replicating the kernel panic manually.

Sounds very much like oom killer gone nuts.

> # growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
> 
> Anyway, if anyone wants to investigate this further, I can provide
> access to the machine (email me).  Otherwise, I'm probably just going to
> wait for -rc2 and see if the problem's still there.

Wait no longer, it's here ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
