Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311692AbSCVJyi>; Fri, 22 Mar 2002 04:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311637AbSCVJy2>; Fri, 22 Mar 2002 04:54:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311692AbSCVJyT>;
	Fri, 22 Mar 2002 04:54:19 -0500
Date: Fri, 22 Mar 2002 01:50:24 -0800 (PST)
Message-Id: <20020322.015024.56054194.davem@redhat.com>
To: sjahn@zooin.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux tuning issue for udp live streaming application
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <001b01c1d186$f5c9a3e0$a31f3fd3@sjahn>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Sangjoon Ahn" <sjahn@zooin.net>
   Date: Fri, 22 Mar 2002 18:50:12 +0900
   
   I want to know the tuning issues suitable for our solution. Also, we want to
   use a zero-copy api of udp, but we don't know usage of the api and whether
   it is support on Linux kernel 2.4.18. If it is supported, how can I find it.

Zerocopy is not supported for UDP.  It may be implemented in the
future.  If an when we will do this is unknown, so please don't ask.
