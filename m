Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130126AbQK3Evr>; Wed, 29 Nov 2000 23:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129937AbQK3Ev2>; Wed, 29 Nov 2000 23:51:28 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129911AbQK3Ev0>;
        Wed, 29 Nov 2000 23:51:26 -0500
Subject: Re: rocketport pci question... it stopped working after 250 days uptime
To: donfede@casagrau.org (Federico Grau)
Date: Thu, 30 Nov 2000 03:27:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001129213933.A5309@casagrau.org> from "Federico Grau" at Nov 29, 2000 09:39:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141KNy-0006mA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These three boxes had similar uptimes (since their last kernel rebuild); 249
> days, 248 days, 250 days.  Comparing the logs of each box, we saw that each
> box's rocketport stopped working after aproximately 248 days 16 hours uptime.
> So, my questions are:
>  - has anyone heard of such a bug before?

Yes. Someone is doing signed maths on time stamps (2^31 1/100th of a second)

Ted ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
