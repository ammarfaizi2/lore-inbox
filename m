Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268959AbRHBPCU>; Thu, 2 Aug 2001 11:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268986AbRHBPCK>; Thu, 2 Aug 2001 11:02:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18962 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268959AbRHBPCA>; Thu, 2 Aug 2001 11:02:00 -0400
Subject: Re: [PATCH] make psaux reconnect adjustable
To: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 16:03:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, garloff@suse.de, torvalds@transmeta.com,
        brent@linux1.org, linux-kernel@vger.kernel.org, mantel@suse.de,
        rubini@vision.unipv.it
In-Reply-To: <no.id> from "Andries.Brouwer@cwi.nl" at Aug 02, 2001 11:55:51 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SK06-0000p2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> who asked for this code): if what I say is correct you should
> always see 00 following the AA. So, there may exist a more cautious
> patch that will bite fewer people and does not react to AA but to
> the sequence AA 00.

2.2 has had the sysctl for ages, and it defaults to off
