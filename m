Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUGZDfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUGZDfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 23:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUGZDfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 23:35:48 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:28937 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264917AbUGZDfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 23:35:45 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@osdl.org, gotrooted@pop.com.br, linux-kernel@vger.kernel.org,
       maillist@jg555.com, ramon.rey@hispalinux.es
From: Tim Connors <tconnors+linuxkernel1090812328@astro.swin.edu.au>
Subject: Re: Future devfs plans (sorry for previous incomplete message)
In-reply-to: <200407261737.i6QHbff04878@freya.yggdrasil.com>
References: <200407261737.i6QHbff04878@freya.yggdrasil.com>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-8783-19054-200407261325-tc@hexane.ssi.swin.edu.au>
Date: Mon, 26 Jul 2004 13:34:30 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> said on Mon, 26 Jul 2004 10:37:41 -0700:
> 	3. hardware that is incidentally plugged in, but which might not
> 	   be used in the current session from boot to shutdown.  With the
> 	   increasing popularity of USB and firewire, a user might have a
> 	   "webcam", a still digital camera, a digital video converter, a
> 	   flash reader, a printer, a scanner and an external disk that
> 	   happen attached to the computer's USB network, with the user
> 	   having no intention of using any of them during the current
> 	   session from boot to shutdown.  This way, the cost of leaving
> 	   some things plugged in for convenience is reduced.

Can udev etc handle the case where you have a parallel zip disk
attached with a passthrough parallel port to the printer?

You can only have one of the lp or ppa drivers loaded at a time, and
that is easy enough to do with autoloading of modules and devfs. It
sounds like this is something which udev wouldn't be able to handle,
and hence would be quite a regression.

(please correct me if I am wrong)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Hacking's just another word for nothing left to kludge.
