Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVCXQaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVCXQaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVCXQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:30:23 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:44244 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261550AbVCXQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:30:17 -0500
Date: Thu, 24 Mar 2005 11:29:46 -0500
To: Asfand Yar Qazi <ay1204@qazi.f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Message-ID: <20050324162946.GK17865@csclub.uwaterloo.ca>
References: <3LwFC-4Ko-15@gated-at.bofh.it> <3LwYW-4Xx-11@gated-at.bofh.it> <3LwYZ-4Xx-25@gated-at.bofh.it> <42428FCE.7070901@qazi.f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42428FCE.7070901@qazi.f2s.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 10:00:46AM +0000, Asfand Yar Qazi wrote:
> http://www.neoseeker.com/Articles/Hardware/Previews/nvnforce4/3.html
> 
> You're right there - some semi-hardware support combined with drivers 
> apparently result in lower CPU usage that software firewalls.  Apparently.
> 
> Actually, these people like it:
> http://www.bjorn3d.com/read.php?cID=712&pageID=1096
> 
> However one feature that you can't laugh at is the fact that it can be 
> made to block packets in the span of time between the OS being loaded 
> up, and the "real" firewall coming up.  This small time span 
> theoretically leaves the PC vulnerable, so I think this is the only 
> use for "ActiveAmor Firewall".

Until the OS loads network drivers AND configures IP support AND starts
accepting packets in, there is nothing for the firewall to do.
Certainly on Linux I can make sure iptables is populated (or least has a
sane policy set) before I bring up networking.  In other words: "Who
cares".

> However, this doesn't answer my original question (which I suppose I 
> should have made clearer): can I get SATA II NCQ support in Linux with 
> an nForce 4 chipset?

Don't know.  I think 3ware's controllers do their own NCQ, which is
pretty neat.

Len Sorensen
