Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbULKPKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbULKPKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbULKPKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:10:51 -0500
Received: from fsmlabs.com ([168.103.115.128]:30145 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261939AbULKPKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:10:48 -0500
Date: Sat, 11 Dec 2004 08:07:07 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
In-Reply-To: <20041206192243.GC1435@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041205232007.7edc4a78.akpm@osdl.org> <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
 <20041206160405.GB1271@us.ibm.com> <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
 <20041206192243.GC1435@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Paul E. McKenney wrote:

> My bad -- I hadn't read through the entire thread before responding,
> so was speculating on how it might manage to be correct.

Ok, i'll come up with a method which doesn't use RCU. Thank you, for 
pointing out the faults.

	Zwane
