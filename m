Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSCRENg>; Sun, 17 Mar 2002 23:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312197AbSCREN1>; Sun, 17 Mar 2002 23:13:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57274 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312194AbSCRENM>;
	Sun, 17 Mar 2002 23:13:12 -0500
Date: Sun, 17 Mar 2002 20:09:49 -0800 (PST)
Message-Id: <20020317.200949.32384373.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16m3Dt-0005Hr-00@the-village.bc.nu>
In-Reply-To: <20020316000629.AAA989@shell.webmaster.com@whenever>
	<E16m3Dt-0005Hr-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Sat, 16 Mar 2002 01:43:05 +0000 (GMT)
   
   Dave's suggestion is netfilter - and netfilter is fast enough I
   think. You only need filters on stuff you have already decided is
   for your IP too.

After some thinking, the TAP idea is even nicer as it guarentees zero
overhead, make it such that you only route the BGP stuff over the
device having the TAP attached (make a dummy eth alias just for this
purpose).

