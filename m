Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbRAOTmb>; Mon, 15 Jan 2001 14:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131057AbRAOTmW>; Mon, 15 Jan 2001 14:42:22 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:43781 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130670AbRAOTmG>;
	Mon, 15 Jan 2001 14:42:06 -0500
Date: Mon, 15 Jan 2001 19:42:16 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: David Balazic <david.balazic@uni-mb.si>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: MTRR type AMD Duron/intel ?
In-Reply-To: <3A6350EA.884AC527@uni-mb.si>
Message-ID: <Pine.LNX.4.30.0101151937460.8658-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, David Balazic wrote:

> It also reports something like :
> PCI chipset unknown : assuming transparent

Are you sure it's not

Unknown bridge resource 0: assuming transparent

(which is just about every kernel log I have seen...)

Last time I checked this was issued for perfectly known and valid bridges
that advertice no IO resources.  Isn't it a bit silly to issue that
warning for that case, or am I missing something?

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
