Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbQKHXH3>; Wed, 8 Nov 2000 18:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKHXHT>; Wed, 8 Nov 2000 18:07:19 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1801 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129508AbQKHXHC>;
	Wed, 8 Nov 2000 18:07:02 -0500
Message-ID: <3A09DC6E.682CEC54@mandrakesoft.com>
Date: Wed, 08 Nov 2000 18:06:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hiren_mehta@agilent.com
CC: linux-kernel@vger.kernel.org
Subject: Re: accessing on-card ram/rom
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718808E5@xsj02.sjs.agilent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hiren_mehta@agilent.com wrote:
> I looked at the IO-mapping.txt file. It says that
> on x86 architecture it should not make any difference.
> It also says that "on x86 it _is_ the same memory space. So
> on x86 it actually works to just dereference a pointer".

> Any inputs on this ?

Don't depend on architecture-specific guarantees like this, it could
change, etc.

Use ioremap, it's portable, it's standard, it's the way to go.  ;-)

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
