Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAJD1p>; Tue, 9 Jan 2001 22:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRAJD1f>; Tue, 9 Jan 2001 22:27:35 -0500
Received: from lightmail.com ([207.159.128.77]:63915 "EHLO lightmail.com")
	by vger.kernel.org with ESMTP id <S130548AbRAJD1R>;
	Tue, 9 Jan 2001 22:27:17 -0500
Message-ID: <3A5BD69C.1B2602C6@premierweb.com>
Date: Tue, 09 Jan 2001 19:27:24 -0800
From: Allen Unueco <allen@premierweb.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Where did vm_operations_struct->unmap in 2.4.0 go?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime around test10 or test11 unmap left vm_operations_struct.  The
comment implies its there but it's gone.  Where did it go? 

How do I get a call back for a page unmap?

I ran into this while hacking the Nvidia kernel driver to work with
2.4.0.  I got the driver working but it's not 100%

Also where did get_module_symbol() and put_module_symbol() go?

-Allen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
