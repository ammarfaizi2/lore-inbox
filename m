Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131568AbQLMU5w>; Wed, 13 Dec 2000 15:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131791AbQLMU5m>; Wed, 13 Dec 2000 15:57:42 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:6159 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S131568AbQLMU50>;
	Wed, 13 Dec 2000 15:57:26 -0500
Date: Wed, 13 Dec 2000 12:26:46 -0800
From: alex@foogod.com
To: Tim Riker <Tim@Rikers.org>
Cc: alex@foogod.com, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] I-Opener fix (again)
Message-ID: <20001213122646.D19902@draco.foogod.com>
In-Reply-To: <20001211152331.M10618@draco.foogod.com> <Pine.LNX.4.10.10012122217440.4894-100000@master.linux-ide.org> <20001213114046.B19902@draco.foogod.com> <3A37D9F2.6FB11D82@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A37D9F2.6FB11D82@Rikers.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 01:20:02PM -0700, Tim Riker wrote:
> Andre,
> 
> What are the "laptops that have CFA devices that do not come on channels
> in a pair" systems you refer to?

I assume he's referring to flash devices which show up as an IDE bus with only
a master and no slave, and don't handle slave accesses well (right?).  It
should be noted that my patch does _not_ break these cases at all.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
