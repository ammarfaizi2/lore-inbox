Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTH0GFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTH0GFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:05:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13971 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263170AbTH0GFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:05:42 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Yury Umanets <umka@namesys.com>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: Oleg Drokin <green@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030827055204.GA18114@cse.unsw.EDU.AU>
References: <20030826102233.GA14647@namesys.com>
	 <20030827055204.GA18114@cse.unsw.EDU.AU>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1061964211.15513.41.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 10:03:31 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 09:52, Ian Wienand wrote:
> On Tue, Aug 26, 2003 at 02:22:33PM +0400, Oleg Drokin wrote:
> > Fixed some bugs. And finally reiser4 should compile on 64bit boxes
> > (hm. somebody try it, as I am unable to build any 2.6 kernel for
> > ia64).
> 
> I built this with IA64 2.6.0-test4, it works but there were lots of
> warnings (I can put up a log if you want it).  This was on a dual
> processor Itanium 2 box.
> 
> First up, I tried a little test to make a few files, but once I had
> unmounted the disk I couldn't re-mount it.
> 
> --- example testing below ---

> bash-2.05b# mkfs.reiser4 /dev/sda5
> mkfs.reiser4 0.4.12
> Copyright (C) 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4progs/COPYING.
>  
> Information: Reiser4 is going to be created on /dev/sda5.
> (Yes/No): Yes
> Creating reiser4 on /dev/sda5...
> mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f7661
> mkfs.reiser4(5676): unaligned access to 0x60000000000242fa, ip=0x20000000000f77a1
> mkfs.reiser4(5676): unaligned access to 0x6000000000024302, ip=0x20000000000f78e1
> mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f2671
> done
> Synchronizing /dev/sda5...done

I will fix it soon.

Thanks for report.

Regards.

