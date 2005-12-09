Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVLIVIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVLIVIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVLIVIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:08:47 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1461 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932429AbVLIVIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:08:46 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051209204151.GH32168@quicksilver.road.mcmartin.ca>
References: <1134154208.14363.8.camel@mindpipe>
	 <20051209195816.GF32168@quicksilver.road.mcmartin.ca>
	 <1134159677.18432.7.camel@mindpipe>
	 <20051209204151.GH32168@quicksilver.road.mcmartin.ca>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 16:10:13 -0500
Message-Id: <1134162614.18432.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 15:41 -0500, Kyle McMartin wrote:
> On Fri, Dec 09, 2005 at 03:21:16PM -0500, Lee Revell wrote:
> > I tried with CROSS_COMPILE="/usr/x86_64/bin/x86_64-linux-", but edited
> > the Makefile to set CC to /use/bin/gcc.  Same error.
> >
> 
> Ah. I didn't realize when it says "AS foo.o" it really means it's running
> CC, not AS. (I had also built a cross compiling gcc, but didn't realize it
> was being used). 

The problem does not seem to be lack of x86-64 support in the assembler.
I symlinked /usr/bin/as to /usr/x86_64/bin/x86_64-linux-as and got the
exact same relocation error.

Lee

