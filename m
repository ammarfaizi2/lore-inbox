Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314221AbSEITWZ>; Thu, 9 May 2002 15:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314228AbSEITWZ>; Thu, 9 May 2002 15:22:25 -0400
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:17131 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S314221AbSEITWY>;
	Thu, 9 May 2002 15:22:24 -0400
Date: Thu, 9 May 2002 15:22:24 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020509192224.GA30315@nevyn.them.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com> <3CD8DAA2.6080907@evision-ventures.com> <20020509131341.A37@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 01:13:42PM +0000, Pavel Machek wrote:
> Hi!
> 
> > BTW. If one needs the size of the disk well we could
> > attach it as a file size to the device file in /dev IMHO. Why not?
> 
> Seems like good idea. (I don't know how happy du is going to be that. OTOH
> is du is not happy, we should fix it not to count block devices...)
> 								Pavel

The number /usr/bin/du shows is the block usage, not the logical size;
you could use the logical size for this...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
