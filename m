Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSLUHGe>; Sat, 21 Dec 2002 02:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266760AbSLUHGe>; Sat, 21 Dec 2002 02:06:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52190 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266755AbSLUHGd>;
	Sat, 21 Dec 2002 02:06:33 -0500
Date: Fri, 20 Dec 2002 23:08:36 -0800 (PST)
Message-Id: <20021220.230836.40590865.davem@redhat.com>
To: krkumar@us.ibm.com
Cc: kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] memory leak in ndisc_router_discovery
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212121905.gBCJ5hn18058@eng2.beaverton.ibm.com>
References: <200212121905.gBCJ5hn18058@eng2.beaverton.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Krishna Kumar <krkumar@us.ibm.com>
   Date: Thu, 12 Dec 2002 11:05:43 -0800 (PST)

   I had sent this earlier, there is a bug in router advertisement handling code,
   where the reference (and memory) to an inet6_dev pointer can get leaked (this
   leak can happen atmost once for each interface on a system which receives
   invalid RA's). Below is the patch against 2.5.51 to fix it.

Applied, thanks.
