Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbQLVJUD>; Fri, 22 Dec 2000 04:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131568AbQLVJTx>; Fri, 22 Dec 2000 04:19:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131330AbQLVJTi>; Fri, 22 Dec 2000 04:19:38 -0500
Subject: Re: recommended gcc compiler version
To: reaster@comptechnews.com (Robert B. Easter)
Date: Fri, 22 Dec 2000 08:51:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0012212320430F.02217@comptechnews> from "Robert B. Easter" at Dec 21, 2000 11:20:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149NvR-0004Kz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a newbie question, but what are the recommended gcc compiler versions 
> for compiling,
> 
> Linux 2.2.18?
> Linux 2.4.0?

For i386

2.2.18
	gcc 2.7.2 or egcs-1.1.2
	gcc 2.95 and current Red Hat 2.96 both seem to generate valid kernels
		but are not recommended (insufficient testing)

2.4.0test
	egcs-1.1.2
	(gcc 2.95 miscompiles some of the long long uses)
	Red Hat's 2.96 seems to generate valid kernels but don't expect
		sympathy if you report a bug in one built that way

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
