Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTLZBHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTLZBHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:07:31 -0500
Received: from c-67-166-107-168.client.comcast.net ([67.166.107.168]:35719
	"EHLO eglifamily.dnsalias.net") by vger.kernel.org with ESMTP
	id S264428AbTLZBH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:07:29 -0500
Date: Fri, 26 Dec 2003 01:07:15 +0000 (UTC)
From: dan@eglifamily.dnsalias.net
To: Eric <eric@cisu.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 problems
In-Reply-To: <200312251607.31868.eric@cisu.net>
Message-ID: <Pine.LNX.4.44.0312260106510.1888-100000@eglifamily.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SA-Exim-Mail-From: dan@eglifamily.dnsalias.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Dec 2003, Eric wrote:

> On Thursday 25 December 2003 02:57 pm, dan@eglifamily.dnsalias.net wrote:
> > I grabbed the 2.6.0 code yesterday. But when I tried to compile a
> > modular kernel, I got a *LOT* of unresolved symbols in the modules. I'm
> > attaching the stderr output from depmod's run of make modules_install.
> 	I had this problem with a RH9 install. Instead of modutils, upgrade the the 
> latest module-init-tools from ftp://kernel.org.
> 	The problem is that most of the module loading code has been moved from 
> userspace to kernel code to make module loading more portable. Be sure to 
> follow the upgrade instructions carefully. If done correctly it will keep 
> your old modutils in case you load a 2.4.x kernel and will default to the new 
> module-init-tools for 2.6.x kernels.

I'll try that, thanks!

Any ideas on the blank screen issue?

--- Dan



