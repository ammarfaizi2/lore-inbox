Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbULTXdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbULTXdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULTX3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:29:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3299 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261701AbULTX0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:26:23 -0500
Date: Mon, 20 Dec 2004 15:26:10 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Message-ID: <20041220232610.GB2466@us.ibm.com>
References: <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com> <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com> <29495f1d04121818403f949fdd@mail.gmail.com> <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com> <1103505344.5093.4.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com> <1103507784.5093.9.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com> <20041220182711.GA13972@us.ibm.com> <Pine.LNX.4.61.0412201556130.12334@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412201556130.12334@montezuma.fsmlabs.com>
X-Operating-System: Linux 2.6.10-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 03:57:59PM -0700, Zwane Mwaikambo wrote:
> On Mon, 20 Dec 2004, Nishanth Aravamudan wrote:
> 
> > I believe the only files/patches that needed to be changed were the process.c
> > changes. Here they are re-worked to use ssleep(1) instead of
> 
> This makes it hard for the person integrating the patches to graft them 
> together. How about just rediffing the whole lot so that my original patch 
> gets replaced? Ideally it should be able to resolve the issue in 2.6-bk 
> standalone.

Sorry about that, I will do that next time, thanks for the info.

-Nish
