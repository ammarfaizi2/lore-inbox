Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRDAHei>; Sun, 1 Apr 2001 03:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRDAHe3>; Sun, 1 Apr 2001 03:34:29 -0400
Received: from [63.95.87.168] ([63.95.87.168]:36874 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132037AbRDAHe0>;
	Sun, 1 Apr 2001 03:34:26 -0400
Date: Sun, 1 Apr 2001 03:33:14 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Revised memory-management stuff (was: OOM killer)
Message-ID: <20010401033314.A11443@xi.linuxpower.cx>
In-Reply-To: <l03130300b6ec6062bf7d@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <l03130300b6ec6062bf7d@[192.168.239.105]>; from chromi@cyberspace.org on Sat, Mar 31, 2001 at 10:03:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2001 at 10:03:28PM -0800, Jonathan Morton wrote:
[snip]
> Issue 3:
> 	The OOM killer was frequently killing the "wrong" process.  I have
> developed an improved badness selector, and devised a possible means of
> specifying "don't touch" PIDs at runtime.  PID 1 is never selected for
> killing.  I am debating whether to allow selection of *any* process
> labelled "init" and running as root for the chop, since one of the "unusual
> but frequently encountered" scenarios is for a second init to be running
> during an install or recovery procedure.  This might make it's way in as an
> optional feature.

IO/memory direct hardware access capability holding processes should be at
the bottom of the list.

