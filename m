Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130030AbQKXTXJ>; Fri, 24 Nov 2000 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130031AbQKXTW7>; Fri, 24 Nov 2000 14:22:59 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:64516 "EHLO
        imladris.demon.co.uk") by vger.kernel.org with ESMTP
        id <S130030AbQKXTWt>; Fri, 24 Nov 2000 14:22:49 -0500
Date: Fri, 24 Nov 2000 18:52:45 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Recent patch to cfi.h screws MTD CFI layer
In-Reply-To: <200011241756.eAOHutB16267@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0011241851030.18611-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Russell King wrote:

> The recent patch in 2.4.0-test11 causes MTD to oops the kernel:

Fixed in my tree. That and other things will be fixed when I flush the
latest CFI code to Linus - probably quite soon.

The inter_module_ stuff has introduced link order dependencies too. I'm
working on fixing that.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
