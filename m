Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbSLUHCz>; Sat, 21 Dec 2002 02:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbSLUHCz>; Sat, 21 Dec 2002 02:02:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47326 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266735AbSLUHCy>;
	Sat, 21 Dec 2002 02:02:54 -0500
Date: Fri, 20 Dec 2002 23:05:28 -0800 (PST)
Message-Id: <20021220.230528.106417474.davem@redhat.com>
To: kiran@in.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, dipankar@in.ibm.com,
       akpm@digeo.com
Subject: Re: [patch] Make rt_cache_stat use kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021216192212.C26076@in.ibm.com>
References: <20021216192212.C26076@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ravikiran G Thirumalai <kiran@in.ibm.com>
   Date: Mon, 16 Dec 2002 19:22:12 +0530

   Here's another patch to use kmalloc_percpu.  As usual, this removes
   NR_CPUS bloat, can work when modulized and helps node local allocation.

I can't consider this seriously until the kmalloc_percpu stuff
actually makes it into Linus's tree.  Last I checked, Andrew had
a lot of legitimate gripes with the ideas.
