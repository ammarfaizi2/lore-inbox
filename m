Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSGOI5W>; Mon, 15 Jul 2002 04:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSGOI5V>; Mon, 15 Jul 2002 04:57:21 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:833 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317395AbSGOI5T>; Mon, 15 Jul 2002 04:57:19 -0400
Date: Mon, 15 Jul 2002 09:59:54 +0100
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: [Announce] device-mapper beta3 (fast snapshots)
Message-ID: <20020715085954.GB3432@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2F6464.60908@us.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Fri, Jul 12, 2002 at 06:21:08PM -0500, Andrew Theurer wrote:
> Thanks for the results.  I tried the same thing, but with the latest 
> release (beta 4) and I am not observing the same behavior.  Your results 
> show very little difference in performance when using different chunk 
> sizes for snapshots, but I observed a range of 10 to 24 seconds for this 
> same test on beta4 (I have also included EVMS 1.1 pre4):

I must admit your results are strange to say the least, the only
explanation that I can think of at the moment is that you have been
running LVM1.

Just to reassure me that this is not the case, can you please make
sure that the LVM1 driver is not available, and that your path are not
picking up old LVM1 tools by mistake.  There was a time when the tools
were installed in /usr/sbin rather than /sbin.

- Joe
