Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUCYVi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUCYVi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:38:56 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:40685 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S263620AbUCYViz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:38:55 -0500
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was
	Re: Your opinion on the merge?]]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200403250857.08920.matthias.wieser@hiasl.net>
References: <20040323233228.GK364@elf.ucw.cz>
	 <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz>
	 <200403250857.08920.matthias.wieser@hiasl.net>
Content-Type: text/plain
Message-Id: <1080247142.6679.3.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Fri, 26 Mar 2004 08:39:03 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, here's an example where having the /proc interface is a good
thing: which do you use? zip compression, lzf compression or no
compression? Until recently I always used lzf compression. I just
upgraded my laptop's hard drive, and found I wasn't getting the
performance improvements in suspending I expected. It turns out that the
CPU is now the limiting factor. Because I had the /proc interface, I
could easily adjust the debug settings to show me throughput and then
try a couple of suspend cycles with compression enabled and with it
disabled. Without the /proc interface, I would have had to have
recompiled the kernel to switch settings. (I didn't try gzip because I
knew it wasn't going to be a contender for me).

Regards,

Nigel

On Thu, 2004-03-25 at 19:57, Matthias Wieser wrote:
> On Thursday 25 March 2004 02:41, Pavel Machek wrote:
> > * I'd say that one compression method should be enough for everyone
> No:
> 
> Fast Compression algorithm: lzw
> Good Compression algorithm: gzip 
> 
> That is the reason, 2 algorithm may exist and have their reason.
> 
> Ciao, Matthias
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

