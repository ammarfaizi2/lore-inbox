Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTKZS7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTKZS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:59:39 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:60164 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263325AbTKZS7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:59:38 -0500
Date: Thu, 27 Nov 2003 03:59:56 +0900 (JST)
Message-Id: <20031127.035956.41356622.yoshfuji@linux-ipv6.org>
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, yoshfuji@linux-ipv6.org
Subject: Re: BUG (non-kernel), can hurt developers.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
References: <Pine.LNX.4.53.0311261153050.10929@chaos>
	<Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0311261021400.1524@home.osdl.org> (at Wed, 26 Nov 2003 10:29:54 -0800 (PST)), Linus Torvalds <torvalds@osdl.org> says:

> You can't just randomly use library functions in signal handlers. You can
> only use a very specific "signal-safe" set.
> 
> POSIX lists that set in 3.3.1.3 (3f), and says
> 
> 	"All POSIX.1 functions not in the preceding table and all
> 	 functions defined in the C standard {2} not stated to be callable
> 	 from a signal-catching function are considered to be /unsafe/
> 	 with respect to signals. .."
> 
> typos mine.

Just FYI:
http://www.opengroup.org/onlinepubs/007904975/functions/xsh_chap02_04.html#tag_02_04_03

--yoshfuji
