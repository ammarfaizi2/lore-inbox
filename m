Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274583AbRITRzQ>; Thu, 20 Sep 2001 13:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274585AbRITRzG>; Thu, 20 Sep 2001 13:55:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41228 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274583AbRITRyv>; Thu, 20 Sep 2001 13:54:51 -0400
Subject: Re: [PATCH] fix register_sysrq() in 2.4.9++
To: rddunlap@osdlab.org (Randy.Dunlap)
Date: Thu, 20 Sep 2001 18:59:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com (Linus),
        linux-kernel@vger.kernel.org (lkml), sfr@canb.auug.org.au,
        crutcher+kernel@datastacks.com
In-Reply-To: <3BAA2BF6.467CEB10@osdlab.org> from "Randy.Dunlap" at Sep 20, 2001 10:48:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k86n-0005lE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, I considered that, and it doesn't matter to me whether it
> reports 0 or -1, but it's the data pointer that (mostly) requires
> the #ifdefs, unless the data is always present or a dummy data pointer
> is used.... ?

#define it to an inline without some arguments ?

Alan
