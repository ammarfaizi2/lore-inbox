Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSJCNfn>; Thu, 3 Oct 2002 09:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263273AbSJCNfm>; Thu, 3 Oct 2002 09:35:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60935 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263287AbSJCNfc>; Thu, 3 Oct 2002 09:35:32 -0400
Date: Thu, 3 Oct 2002 14:40:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mike Galbraith <efault@gmx.de>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] backtrace
Message-ID: <20021003144058.D2304@flint.arm.linux.org.uk>
References: <Your <3D9C004A.3080006@corvil.com> <7453.1033637889@ocs3.intra.ocs.com.au> <5.1.0.14.2.20021003114625.00b7ea20@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20021003114625.00b7ea20@pop.gmx.net>; from efault@gmx.de on Thu, Oct 03, 2002 at 12:03:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:03:27PM +0200, Mike Galbraith wrote:
> At 07:38 PM 10/3/2002 +1000, Keith Owens wrote:
> >Most architectures compile with -fomit-frame-pointer (except for ARM
> >where RMK does it differently).  Neither gdb not glibc can cope with
> >kernel code built with -fomit-frame-pointer.  See the horrible
> >heuristics kdb has to apply to get any sort of backtrace on i386.
> 
> IIRC, r~ once mentioned that it was going to get worse. He also mentioned 
> dwarf2 (sp) as a possible solution.  Did you ever look into that?

There was the offer by someone to supply some code, which as per usual
came to nothing.

Therefore its just a bad rumour as far as I'm concerned.  I can't do
everything, my days are full enough as it is.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

