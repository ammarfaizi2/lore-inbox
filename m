Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbQKMPyb>; Mon, 13 Nov 2000 10:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129918AbQKMPyL>; Mon, 13 Nov 2000 10:54:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13318 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129050AbQKMPyG>;
	Mon, 13 Nov 2000 10:54:06 -0500
Message-ID: <3A100E7A.2F00682E@mandrakesoft.com>
Date: Mon, 13 Nov 2000 10:53:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven_Snyder@3com.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Current doc for writing device drivers?
In-Reply-To: <88256996.00570596.00@hqoutbound.ops.3com.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven_Snyder@3com.com wrote:
> My device driver reference "Linux Device Drivers" (Rubini, published by O'Reilly
> on Feb. '98) is getting pretty long in the tooth.  The book's primary focus is
> on Linux v2.0.x, with some v2.2.x material tacked on to the end.
> 
> What reference(s) are recommended for current (v2.2/v2.4) Linux kernels?

The Rubini book is being updated for 2.2 and 2.4, but I dunno when it
will go to press.

The best reference is the source code.  When working with the Linux
kernel, you -quickly- learn to hone your code-reading skills, because
the code is the best documentation.

When you want to figure out how to do something, find a similar example
in the kernel source tree.  When you want to figure out the conditions
under which certain code is called, examine all callers.  And all
callers of callers.  Until you are satisfied you see the complete call
path.

Use the source Luke :)

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
