Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129286AbRBFW1v>; Tue, 6 Feb 2001 17:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRBFW1q>; Tue, 6 Feb 2001 17:27:46 -0500
Received: from raven.toyota.com ([63.87.74.200]:29966 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129416AbRBFW1e>;
	Tue, 6 Feb 2001 17:27:34 -0500
Message-ID: <3A807A53.753AFB7F@toyota.com>
Date: Tue, 06 Feb 2001 14:27:31 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ibmtr.o does not like 2.4 [Was: IBM Model 350 does not like 2.4]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just to follow up on my own post, the problem is
way down in the network driver layer, specifically
in the ibmtr driver - it seems to be happy with 2.2,
and barfs with 2.4 - for now I replaced it with an
IBM pci card (olympic driver) and 2.4 is now solid
on the machine that had serious problems using
the isa token ring card.

I'l have a look at ibmtr if nobody beats me to it.

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
