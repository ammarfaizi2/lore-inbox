Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbULTXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbULTXVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbULTXPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:15:10 -0500
Received: from fsmlabs.com ([168.103.115.128]:23778 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261705AbULTXEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:04:47 -0500
Date: Mon, 20 Dec 2004 15:57:59 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <20041220182711.GA13972@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0412201556130.12334@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
 <29495f1d04121818403f949fdd@mail.gmail.com> <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
 <1103505344.5093.4.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
 <1103507784.5093.9.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
 <20041220182711.GA13972@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Nishanth Aravamudan wrote:

> I believe the only files/patches that needed to be changed were the process.c
> changes. Here they are re-worked to use ssleep(1) instead of

This makes it hard for the person integrating the patches to graft them 
together. How about just rediffing the whole lot so that my original patch 
gets replaced? Ideally it should be able to resolve the issue in 2.6-bk 
standalone.

Thanks,
	Zwane

