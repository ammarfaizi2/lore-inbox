Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSLDQ5D>; Wed, 4 Dec 2002 11:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLDQ5D>; Wed, 4 Dec 2002 11:57:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32980 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266886AbSLDQ5C>;
	Wed, 4 Dec 2002 11:57:02 -0500
Date: Wed, 04 Dec 2002 09:01:52 -0800 (PST)
Message-Id: <20021204.090152.97851491.davem@redhat.com>
To: kiran@in.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@digeo.com,
       dipankar@in.ibm.com
Subject: Re: [patch] Change Networking mibs to use kmalloc_percpu -- 1/3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021204180510.C17375@in.ibm.com>
References: <20021204180510.C17375@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ravikiran G Thirumalai <kiran@in.ibm.com>
   Date: Wed, 4 Dec 2002 18:05:10 +0530

   Here's a patchset to enable networking mibs to use kmalloc_percpu instead
   of the traditional padded NR_CPUS arrays.
   
   Advantages:
   1. Removes NR_CPUS bloat due to static definition
   2. Can support node local allocation
   3. Will work with modules
   
I totally support this work.  Once the kmalloc percpu bits hit
Linus's tree, just retransmit these diffs to me privately and
I'll put them into my net-2.5 tree.

Thanks.
