Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270133AbRHWTSP>; Thu, 23 Aug 2001 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270138AbRHWTSI>; Thu, 23 Aug 2001 15:18:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51209 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270133AbRHWTR5>; Thu, 23 Aug 2001 15:17:57 -0400
Subject: Re: macro conflict
To: jimlay@u.washington.edu (J. Imlay)
Date: Thu, 23 Aug 2001 20:21:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.33.0108231150110.64144-100000@dante14.u.washington.edu> from "J. Imlay" at Aug 23, 2001 12:03:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a02V-0004Ps-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem here with AFS is that it needs the old definition but the old
> definition is being over written by the new one... you guys should know
> all this. But I am just saying that I really think the new macro
> min(type,x,y) should get a new name. like type_min or something.

Yep. Thats one of the reasons I've not yet moved to 2.4.9 derived trees
for -ac. Its going to require I schedule some time to fix up every single
bogus min/max change in Linus tree
