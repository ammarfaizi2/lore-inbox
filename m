Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUAEXkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUAEXiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:38:12 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:42248 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266008AbUAEXhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:37:33 -0500
Date: Mon, 5 Jan 2004 23:37:31 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: dan@eglifamily.dnsalias.net
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 problems
In-Reply-To: <Pine.LNX.4.44.0312251936200.3243-300000@eglifamily.dnsalias.net>
Message-ID: <Pine.LNX.4.44.0401052336510.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, when I use FrameBuffers and logo support, I get nothing. The kernel 
> boots, I see the "decompressing" line, then the screen goes black like 
> it's changing video modes (which it should because my lilo.conf sets the 
> video mode), and never comes back. The kernel seems to be booting OK, 
> after a while I can ping the machine, but I am completely unable to see 
> anything on the screen attached to the 2.6 machine. 
> 
> I'm also attaching the .config file I used to build the kernel. I built it 
> as so:

This is a bug in the standard tree. I have patch that fixes that issue.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


