Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRAPXhj>; Tue, 16 Jan 2001 18:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbRAPXh3>; Tue, 16 Jan 2001 18:37:29 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:55710 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S132556AbRAPXhU>; Tue, 16 Jan 2001 18:37:20 -0500
Message-ID: <3A64DB2D.A133DB66@inet.com>
Date: Tue, 16 Jan 2001 17:37:17 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Cort Dougan <cort@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: lance.c @ 100Mbit
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all who pointed out the pcnet32.c driver!  (And quickly, too. 
Perhaps one day I'll learn to do a "grep -i 79C973 drivers/net/*"
first.  *sigh*)

Now to see if I can get it to work on an ARM-based system...    gotta
love lack of cache-coherance.  ;)  (dma_cache_inv, etc.)  I'm open to
suggestions on that as well.  :)

Thanks again!

Eli
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
