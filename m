Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVLIVeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVLIVeH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVLIVeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:34:07 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19384 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964879AbVLIVeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:34:05 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kyle McMartin <kyle@mcmartin.ca>
In-Reply-To: <1134163506.5238.18.camel@localhost.localdomain>
References: <1134154208.14363.8.camel@mindpipe>
	 <20051209195816.GF32168@quicksilver.road.mcmartin.ca>
	 <1134159677.18432.7.camel@mindpipe>
	 <20051209204151.GH32168@quicksilver.road.mcmartin.ca>
	 <1134161906.18432.15.camel@mindpipe>
	 <1134163506.5238.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 16:35:33 -0500
Message-Id: <1134164133.18432.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 16:25 -0500, Steven Rostedt wrote:
> For my x86_64, I gave up on trying to do it through the normal path
> (having a plain debian unstable system), and finally just downloaded
> the gcc toolchain (gcc, binutils, and glibc) and built them as cross
> compilers with the prefix x86_64-linux-
> 

I was trying to avoid that, as the gcc-4.0-x86-64 package has an
unfortunate dependency on a 70MB glibc-cross-x86-64 package which I
almost certainly don't really need to compile the kernel.

So I guess this is a bug in the Ubuntu 5.10 gcc, I'll report it as such.

Thanks,

Lee

