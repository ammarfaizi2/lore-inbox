Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293495AbSCOXTp>; Fri, 15 Mar 2002 18:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293503AbSCOXTf>; Fri, 15 Mar 2002 18:19:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38817 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293495AbSCOXT0>;
	Fri, 15 Mar 2002 18:19:26 -0500
Date: Fri, 15 Mar 2002 15:16:28 -0800 (PST)
Message-Id: <20020315.151628.122227750.davem@redhat.com>
To: davids@webmaster.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020315231400.AAA28257@shell.webmaster.com@whenever>
In-Reply-To: <E16m0vU-0004xU-00@the-village.bc.nu>
	<20020315231400.AAA28257@shell.webmaster.com@whenever>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Schwartz <davids@webmaster.com>
   Date: Fri, 15 Mar 2002 15:13:59 -0800
   
   	There is no problem with MD5 that makes it unsuitable for this
   particular application. A SHA signature would enlarge each packet,
   further reducing the effective MTU. This would increase the cost of
   what was intended to be a simple mechanism to solve a specific
   problem (spoofed SYNs/RSTs).

Ignoring valid RST frames breaks TCP.

