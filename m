Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTE3HDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 03:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTE3HDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 03:03:50 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:1485 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263354AbTE3HDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 03:03:49 -0400
Date: Fri, 30 May 2003 09:17:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: kwijibo@zianet.com
Cc: Duncan Laurie <duncan@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-ID: <20030530071702.GC14159@louise.pinerecords.com>
References: <20030529114001.GD7217@louise.pinerecords.com> <oprpygljynury4o7@lists.bilicki.com> <3ED690FE.5080602@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED690FE.5080602@zianet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [kwijibo@zianet.com]
> 
> Here is mine which doesn't work.

(Thanks for checking the dumps, Duncan.)

Mine are a bit different:

 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
-00: 66 11 01 02 47 00 00 22 93 00 01 06 00 40 80 00
+00: 66 11 01 02 47 00 00 22 93 00 01 06 00 20 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-40: 00 06 1e 0c 03 00 00 00 07 0f 00 00 00 00 00 00
+40: 20 06 3e 0c 01 00 00 00 07 0f 00 00 00 00 00 00
 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-60: 00 00 00 00 8f c3 d1 15 00 00 00 20 00 00 00 00
+60: 00 00 00 00 ef c3 d1 15 00 00 00 20 00 00 00 00
 70: 0f 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-a0: a1 0e 00 00 80 00 5d 0f ff 0f 04 10 01 aa 00 ac
-b0: 00 07 1c 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: a1 0e 00 00 40 00 5f 0f ff 0f 04 10 01 aa 00 ac
+b0: 00 07 0c 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 03 58 00 00 00 00 00 00 00 00 00 00 00 00
 e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
-00: 66 11 12 02 45 01 00 02 93 82 01 01 08 40 80 00
+00: 66 11 12 02 45 01 00 02 93 82 01 01 00 40 80 00
 10: f1 01 00 00 f5 03 00 00 01 00 00 00 01 00 00 00
 20: 01 20 00 00 00 00 00 00 00 00 00 00 66 11 12 02
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 40: 5d 20 5d 5d ff 00 ff ff 00 01 04 00 00 00 00 00
 50: 00 00 00 00 00 00 00 00 0f 04 03 00 00 00 00 00
 60: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
Tomas Szepe <szepe@pinerecords.com>
