Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbTCHVXP>; Sat, 8 Mar 2003 16:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbTCHVXP>; Sat, 8 Mar 2003 16:23:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49843
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262137AbTCHVXO>; Sat, 8 Mar 2003 16:23:14 -0500
Subject: Re: 2.4.21-pre5-ac2:  kernel oops with "swapoff -a"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E69CEF9.9050808@myrealbox.com>
References: <3E69CEF9.9050808@myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047163205.26745.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 22:40:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 11:07, walt wrote:
> When I do "swapoff -a" I still see the kernel oops that began with -pre4-ac7
> and has propagated to every 'ac' kernel since then.

Yes. There is a nasty bug in the original 2.4 code (and maybe 2.5).
There is a fix in the -ac tree but the fix has a different bug it seems.

> Plain 2.4.21-pre5 does NOT show this problem, so it seems to be a patch that
> was specifically introduced in -pre4-ac7 and I don't know enough to narrow
> it any further than that.  I'm not an accomplished kernel debugger so I
> can't offer much more info than that, but I'd like to help if you can give
> me some hints what kind of information you might need to find the problem.

The patch is staying in -ac until I find out why you hit it. I've had no
other reports so far, but it just be the way your system is calling it.

Can you send me an strace swapoff -a ?

