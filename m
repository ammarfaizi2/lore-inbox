Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbTCSPR6>; Wed, 19 Mar 2003 10:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263046AbTCSPR6>; Wed, 19 Mar 2003 10:17:58 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:16030 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S263035AbTCSPR6>;
	Wed, 19 Mar 2003 10:17:58 -0500
Date: Wed, 19 Mar 2003 16:28:36 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrus <andrus@members.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED UNTILL NOW!)
Message-ID: <20030319152836.GD25934@h55p111.delphi.afb.lu.se>
References: <000001c2ee1f$02da6820$0100a8c0@andrus> <1048087625.30750.34.camel@irongate.swansea.linux.org.uk> <20030319145537.GB25934@h55p111.delphi.afb.lu.se> <1048090385.30750.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048090385.30750.41.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18vfUa-0000XH-00*X2DxBytIOWE* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 04:13:05PM +0000, Alan Cox wrote:
> On Wed, 2003-03-19 at 14:55, Anders Gustafsson wrote:
> > If access can't be shut down while compiling the new kernel 
> > 
> > echo /foo/bar/doesnotexist >/proc/sys/kernel/modprobe
> > 
> > would help, wouldn't it?
> 
> Against the default exploit circulating yes, in the general
> case we don't believe so.

Ah, there might be other stuff than modprobe that execs out of a
kernelthread. But to exploit the kernelthread must execve so there is a
userspaceprocess to ptrace, right?

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
