Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263789AbRFCXQP>; Sun, 3 Jun 2001 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFCXQG>; Sun, 3 Jun 2001 19:16:06 -0400
Received: from pD903C749.dip.t-dialin.net ([217.3.199.73]:33188 "HELO
	enterprise.lokalnetz") by vger.kernel.org with SMTP
	id <S263789AbRFCXP4>; Sun, 3 Jun 2001 19:15:56 -0400
Date: Mon, 4 Jun 2001 01:14:50 +0200
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010604011449.A16006@mobile>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
User-Agent: Mutt/1.3.18i
From: Erik Tews <erik.tews@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 08:37:25PM -0300, Harald Welte wrote:
> Hi!
> 
> Is there any way to read out the compile-time HZ value of the kernel?
> 
> I had a brief look at /proc/* and didn't find anything.
> 
> The background, why it is needed:
> 
> There are certain settings, for example the icmp rate limiting values,
> which can be set using sysctl. Those setting are basically derived from
> HZ values (1*HZ, for example).
> 
> If you now want to set those values from a userspace program / script in
> a portable manner, you need to be able to find out of HZ of the currently
> running kernel.

Have a look at the source of top. There is a lib which can help you to
find out HZ by reading some files from proc.
