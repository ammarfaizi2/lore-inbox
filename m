Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUG2Wyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUG2Wyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267503AbUG2WwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:52:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:5522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267527AbUG2WuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:50:21 -0400
Date: Thu, 29 Jul 2004 15:29:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mnalis@voyager.hr
Cc: Kazrak+kernel@cesmail.net, bunk@fs.tum.de, mnalis-umsdos@voyager.hr,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] remove UMSDOS
Message-Id: <20040729152943.385f05e1.rddunlap@osdl.org>
In-Reply-To: <20040724182627.GA3767@eagle.earth.my>
References: <20040711112821.GC4701@fs.tum.de>
	<6.1.1.1.0.20040711120748.041c8e60@no.incoming.mail>
	<20040724182627.GA3767@eagle.earth.my>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2004 20:26:27 +0200 mnalis@voyager.hr wrote:

| On Sun, Jul 11, 2004 at 12:17:32PM -0600, Jeff Woods wrote:
| > At 7/11/2004 01:28 PM +0200, Adrian Bunk wrote:
| > >UMSDOS in 2.6 is broken, and it seems no one needs it enough to bother 
| > >fixing it.
| 
| Just to notify anybody interested that I have started working on fixing
| UMSDOS support for 2.6 kernels (as there still seems to be some people
| wanting it). 
| 
| Patch that enables UMSDOS to compile and insmod is available at 
| http://linux.voyager.hr/umsdos/
| It still doesn't work (triggers kernel BUG() after few write ops), 
| but I'll post another announcements when I get it in working condition.

I posted a umsdos patch (to build on 2.6.0-test) last October/2003.
See http://marc.theaimsgroup.com/?l=linux-fsdevel&m=106697862024272&w=2
and see Al Viro's reply to that.

Anyway, I just updated my patch to build on 2.6.8-rc2-bk8, so my patch
is quite similar to yours now.  Yours is a small bit ahead of mine.

  http://developer.osdl.org/rddunlap/patches/umsdos-build-268rc2bk8.patch

--
~Randy
