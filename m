Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131981AbQKQM2k>; Fri, 17 Nov 2000 07:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132004AbQKQM2b>; Fri, 17 Nov 2000 07:28:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37381 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131981AbQKQM2P>;
	Fri, 17 Nov 2000 07:28:15 -0500
Message-ID: <3A151D47.172D67E@mandrakesoft.com>
Date: Fri, 17 Nov 2000 06:57:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com> <20001117203325.A15841@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> There are 'hotplug' additions -- these now mean the networking code
> won't build without "CONFIG_HOTPLUG=y".
> 
> What is the correct fix here; fix the networking code or just take
> this option out and ensure hotplug functionality is no longer
> compile-time dependent (always compiled in) ?

Surround the networking code with CONFIG_HOTPLUG.  A patch has already
been posted to lkml.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
