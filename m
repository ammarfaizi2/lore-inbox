Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRJPNaP>; Tue, 16 Oct 2001 09:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276215AbRJPNaF>; Tue, 16 Oct 2001 09:30:05 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:56254 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S276204AbRJPN37>;
	Tue, 16 Oct 2001 09:29:59 -0400
Date: Tue, 16 Oct 2001 15:30:24 +0200
From: David Weinehall <tao@acc.umu.se>
To: Kirill Ratkin <kratkin@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very old kernel.
Message-ID: <20011016153024.X25701@khan.acc.umu.se>
In-Reply-To: <200110161123.f9GBNXw01262@spnew.snpe.co.yu> <20011016103906.97044.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011016103906.97044.qmail@web11906.mail.yahoo.com>; from kratkin@yahoo.com on Tue, Oct 16, 2001 at 03:39:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 03:39:06AM -0700, Kirill Ratkin wrote:
> Hi. Do anybody know how to compile old kernel? (I need
> to compile 2.0.35 verion). I make config and make dep,
> when I do it I see error (during make dep). I found
> this problem as bus error in mkdep binary. I tried to
> take config scripts from 2.4.x kernel and it's ok but
> when I tried to compile I saw many error connected
> with asm statement and function type prefixes (like
> __constant_memcopy). I wouldn't like to install old
> gcc and old binutils. Are there ways to compile old
> kernel with new dev. tools?

The __asm__ in v2.0.xx won't compile with too new binutils (unless you
use v2.0.40-pre[12], where I've fixed this), and a new gcc will
miscompile the x86 port at least.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
