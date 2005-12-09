Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVLIUmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVLIUmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVLIUmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:42:04 -0500
Received: from fattire.cabal.ca ([134.117.69.58]:14789 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S964784AbVLIUmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:42:02 -0500
Date: Fri, 9 Dec 2005 15:41:51 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
Message-ID: <20051209204151.GH32168@quicksilver.road.mcmartin.ca>
References: <1134154208.14363.8.camel@mindpipe> <20051209195816.GF32168@quicksilver.road.mcmartin.ca> <1134159677.18432.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134159677.18432.7.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 03:21:16PM -0500, Lee Revell wrote:
> I tried with CROSS_COMPILE="/usr/x86_64/bin/x86_64-linux-", but edited
> the Makefile to set CC to /use/bin/gcc.  Same error.
>

Ah. I didn't realize when it says "AS foo.o" it really means it's running
CC, not AS. (I had also built a cross compiling gcc, but didn't realize it
was being used). 
