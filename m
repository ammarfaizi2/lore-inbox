Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQKQSn7>; Fri, 17 Nov 2000 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbQKQSnt>; Fri, 17 Nov 2000 13:43:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129942AbQKQSnf>; Fri, 17 Nov 2000 13:43:35 -0500
Subject: Re: ORACLE and 2.4-test10
To: dalecki@evision-ventures.com
Date: Fri, 17 Nov 2000 18:14:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A157E06.37255710@evision-ventures.com> from "dalecki" at Nov 17, 2000 07:50:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wq1g-0000zo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anybody on tell me whatever there are still
> serious pitfalls in running Oracle-8.1.6.1R2 on the

Yes.

> If I rememeber correctly there where some problems with
> SHM handling still left to resolve...

SHM is resolved but O_SYNC is not yet fixed. You could therefore easily lose
your entire database

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
