Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWDURVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWDURVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDURVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:21:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:59303 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751342AbWDURVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:21:25 -0400
Date: Sat, 22 Apr 2006 03:21:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: s0348365@sms.ed.ac.uk, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-Id: <20060422032121.36ee730b.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0604210932020.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	<200604211121.20036.s0348365@sms.ed.ac.uk>
	<Pine.LNX.4.64.0604210932020.3701@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006 09:40:26 -0700 (PDT) Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Fri, 21 Apr 2006, Alistair John Strachan wrote:
> > 
> > Something in here (or -rc1, I didn't test that) broke WINE. x86-64 kernel, 
> > 32bit WINE, works fine on 2.6.16.7. I'll check whether -rc1 had the same 
> > problem and work backwards, but just in case somebody has an idea..
> 
> Nothing strikes me, but maybe Andi has a clue.

Also (and this is probably already known) using a 2G/2G split on i386
kills wine.  At least when attempting to run Lotus Notes under wine, wine
gets a signal 9.  The normal 3G/1G split works fine.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
