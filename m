Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUCYWmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbUCYWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:41:27 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:51126 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263685AbUCYWi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:38:27 -0500
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was
	Re: Your opinion on the merge?]]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040325222745.GE2179@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz>
	 <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz>
	 <200403250857.08920.matthias.wieser@hiasl.net>
	 <1080247142.6679.3.camel@calvin.wpcb.org.au>
	 <20040325222745.GE2179@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080250718.6674.35.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Fri, 26 Mar 2004 09:38:38 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-03-26 at 10:27, Pavel Machek wrote:
> We should select one, and drop the others.
> 
> gzip is useless for almost everyone -> gets little testing -> is
> probably broken.

Nope. Not broken. I used it yesterday in testing some changes you
suggested. I asked about removing it a while back and people said 'No!
We're using it!"

> > upgraded my laptop's hard drive, and found I wasn't getting the
> > performance improvements in suspending I expected. It turns out that the
> > CPU is now the limiting factor. Because I had the /proc interface, I
> > could easily adjust the debug settings to show me throughput and then
> > try a couple of suspend cycles with compression enabled and with it
> > disabled. Without the /proc interface, I would have had to have
> > recompiled the kernel to switch settings. (I didn't try gzip because I
> > knew it wasn't going to be a contender for me).
> 
> Kernel could automagically select the right one.. But I'd prefer for

How? It would need to know the drive throughput, the compression
throughput for each driver... I'm sure you're not suggesting some sort
of utility run during kernel configuration/compilation. (And if you
were, that would assume the computer it was being compiled on was the
computer the kernel would be run on).

> only "non compressed" part to reach mainline for 2.6. Feature freeze
> was few months ago, and "adding possibility to compress swsusp data"
> does not sound like a bugfix to me...

Feature freeze is always half unfrozen anyway. 2.4 just gained XFS! I'm
sure 2.6 would be fine gaining a permutation of suspend with Highmem
support, swap file support, support for multiple swap devices, support
for bootsplash, support for compression and/or encryption and support
for SMP/HT. (Did I forget anything? :>).

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

