Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316402AbSEOPPE>; Wed, 15 May 2002 11:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316399AbSEOPPD>; Wed, 15 May 2002 11:15:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3333 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316402AbSEOPPB>; Wed, 15 May 2002 11:15:01 -0400
Date: Wed, 15 May 2002 11:11:05 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Address space limits in IA32 linux
In-Reply-To: <200205151257.HAA75582@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.3.96.1020515110730.5026A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Jesse Pollard wrote:

> IA32 is by definition limited to 4G. Just because the Kernel may, under
> extreem duress, access more by memory management shenanigans access more,
> user processes are ALWAYS limited to a 32 bit virtual address. Even this
> is more restricted, since shared libraries and other access limits it even
> more. Usually you can stretch it to 3G, but not over that.

Actually you can go to 3.5G now, using readily available patches. However,
your unstated premise is correct, the limit using current kernel and gcc
capabilities is <4G. 

> 
> search the archives - the details are available.

Right, so is 3.5G, but I doubt that anyone with a problem not working in
3G is going to find solace in 3.5G.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

