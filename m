Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135337AbRAJOSK>; Wed, 10 Jan 2001 09:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135594AbRAJOSA>; Wed, 10 Jan 2001 09:18:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135337AbRAJORs>; Wed, 10 Jan 2001 09:17:48 -0500
Subject: Re: Anybody got 2.4.0 running on a 386 ?
To: richardj_moore@uk.ibm.com
Date: Wed, 10 Jan 2001 14:19:26 +0000 (GMT)
Cc: tleete@mountain.net (Tom Leete), rob@sysgo.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <802569D0.0033D9ED.00@d06mta06.portsmouth.uk.ibm.com> from "richardj_moore@uk.ibm.com" at Jan 10, 2001 09:25:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GM64-0000Kc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does linux cater of all the old 386 chip bugs - especially the memory
> management oddities?

So called 'sigma sigma' 386 and higher. Ie we dont support the 386 with the
32bit mul bugs.

Also a lot of 386's crash if you abuse popad instructions from user space and
there is no fix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
