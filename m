Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJMFoP>; Sun, 13 Oct 2002 01:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSJMFoP>; Sun, 13 Oct 2002 01:44:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56715 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261432AbSJMFoO>;
	Sun, 13 Oct 2002 01:44:14 -0400
Date: Sat, 12 Oct 2002 22:43:18 -0700 (PDT)
Message-Id: <20021012.224318.94555090.davem@redhat.com>
To: ahu@ds9a.nl
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] USAGI IPsec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012121650.GA10827@outpost.ds9a.nl>
References: <20021012111759.GA10104@outpost.ds9a.nl>
	<20021012.044137.42774593.davem@redhat.com>
	<20021012121650.GA10827@outpost.ds9a.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bert hubert <ahu@ds9a.nl>
   Date: Sat, 12 Oct 2002 14:16:50 +0200

   Some people on #lartc were wondering about the use of a route cache if there
   is only one route. It was reported that a single default route on a system
   that talks to many destinations would lead to a huge route cache, which is
   probably not more efficient than looking up the simple route.
   
   Would this 'small efficient flow cache' also solve this problem?
   
I contend there is no "problem".  Routing cache entries are
garbage collected, and even this can be tuned via sysctl.
