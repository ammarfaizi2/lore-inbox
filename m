Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281147AbRKENgh>; Mon, 5 Nov 2001 08:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281149AbRKENg1>; Mon, 5 Nov 2001 08:36:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42163 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S281147AbRKENgQ>;
	Mon, 5 Nov 2001 08:36:16 -0500
Date: Mon, 5 Nov 2001 14:35:09 +0100
From: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: 2.4.14-pre7 KERNEL: assertion (sk->pprev==NULL) failed at tcp_ipv4.c(345):__tcp_v4_hash
Message-ID: <20011105143508.A1327@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

After about 40 hours 2.4.14-pre7-xfs (Nov 3 chekout) locked up (I think - no SysRQ
response) leaving in klogs what's below:

Nov  5 12:00:20 main kernel: KERNEL: assertion (sk->pprev==NULL) failed at tcp_ipv4.c(345):__tcp_v4_hash

I believe, that it's related to -pre6 David Miller's net updates.

Now I downgraded to 2.4.10-xfs, which I had been running more successfully
then 2.4.14-pre7 but not flawlessly... 

http://marc.theaimsgroup.com/?l=linux-xfs&m=100473129726291&w=2

Any hints ?

Cheers,
Krzysztof

PS.
linux-kernel subscribers please CC for obvious reasons :>
