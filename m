Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUITRKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUITRKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUITRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:08:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:2220 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266768AbUITRIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:08:15 -0400
Subject: Re: Linux 2.6.9-rc2 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1095700064.2867.30.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 20 Sep 2004 10:07:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 09:40, Linus Torvalds wrote:
> Various things all over the map, most of them not necessarily very visible 
> to most people. ALSA update, and tons of small fixes pretty much 
> everywhere.
> 
> The one thing that people may actually _notice_ is that you get a lot more 
> warnings for some drivers due to the stricter type-checks for PCI memory 
> mapping. They are harmless (code generation should be the same), and we'll 
> work on trying to fix up the drivers as we go along, but they can be a bit 
> daunting if you happen to enable some of the less type-friendly drivers 
> right now..
> 
> 		Linus
> 
> 

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
2.6.8.1        0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
2.6.8          0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e


Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.9-rc2-mm1     0w/0e     2w/0e  3541w/9e   41w/0e   3w/9e   3567w/0e
2.6.9-rc1-mm4     0w/0e     1w/0e    55w/0e    3w/0e   2w/0e     48w/0e
2.6.9-rc1-mm3     0w/0e     0w/0e    55w/13e   3w/0e   1w/0e     49w/1e
2.6.9-rc1-mm2     0w/0e     0w/0e    53w/11e   3w/0e   1w/0e     47w/0e
2.6.9-rc1-mm1     0w/0e     0w/0e    80w/0e    4w/0e   1w/0e     74w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

John



