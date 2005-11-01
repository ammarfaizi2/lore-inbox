Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVKAAfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVKAAfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVKAAfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:35:20 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:15510 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751202AbVKAAfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:35:19 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: New (now current development process)
Date: Mon, 31 Oct 2005 16:34:30 -0800
User-Agent: KMail/1.8.91
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       torvalds@osdl.org, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.61.0511010109100.1386@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511010109100.1386@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311634.31764.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 31, 2005 4:17 pm, Roman Zippel wrote:
> > Are you sure these kernels are feature-equivalent?
>
> Pretty much, on this machine I generally only include what I need, so
> only a few drivers were added, I even have KALLSYMS disabled.

Is it just one top level subsystem that's increasing in size faster than 
the others?  Last time I broke it down, networking (net/built-in.o) was 
the biggest by far, and it does seem to add features at a fast rate (not 
that I'm complaining!).  On FC devel with the FC kernel config:

-rw-rw-r--  1 jbarnes jbarnes 555088 Oct 31 16:33 net/built-in.o 
(stripped)

Jesse
