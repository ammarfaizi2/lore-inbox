Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130472AbQLPGVU>; Sat, 16 Dec 2000 01:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQLPGVJ>; Sat, 16 Dec 2000 01:21:09 -0500
Received: from pedigree.cs.ubc.ca ([142.103.6.50]:30379 "EHLO
	pedigree.cs.ubc.ca") by vger.kernel.org with ESMTP
	id <S129718AbQLPGU6>; Sat, 16 Dec 2000 01:20:58 -0500
Date: Fri, 15 Dec 2000 21:50:31 -0800
From: Dima Brodsky <dima@cs.ubc.ca>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Sound (emu10k1) broken in 2.2.18
Message-ID: <20001215215031.A743@cascade.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The sound (emu10k1) seems to be broken under 2.2.18.
If I do:

	cat x > /dev/dsp

I get:

	bash: /dev/dsp: No such device

But an ls -l shows:

crw-rw-rw-   1 root     sys       14,   3 Dec 15 21:25 dsp
crw-rw-rw-   1 root     sys       14,  19 Dec 15 21:25 dsp1

Same thing with xmms and mpg123.  There were no problems under 2.2.17.

Thanks
ttyl
Dima

-- 
Dima Brodsky                                   dima@cs.ubc.ca
                                               http://www.cs.ubc.ca/~dima
201-2366 Main Mall                             (604) 822-6179 (Office)
Department of Computer Science                 (604) 822-2895 (DSG Lab)
University of British Columbia, Canada         (604) 822-5485 (FAX)

Computers are like Old Testament gods; lots of rules and no mercy.
							  (Joseph Campbell)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
