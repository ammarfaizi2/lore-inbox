Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRASKCt>; Fri, 19 Jan 2001 05:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRASKCj>; Fri, 19 Jan 2001 05:02:39 -0500
Received: from ptldpop3.ptld.uswest.net ([198.36.160.3]:48903 "HELO
	ptldpop3.ptld.uswest.net") by vger.kernel.org with SMTP
	id <S129818AbRASKC3>; Fri, 19 Jan 2001 05:02:29 -0500
Date: Fri, 19 Jan 2001 02:02:43 -0800
From: Mike Glover <mpg4@duluoz.net>
To: linux-kernel@vger.kernel.org
Subject: block size for quotas?
Reply-To: mpg4@duluoz.net
X-Mailer: Spruce 0.7.6 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010119100231Z129818-469+195@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I maintain quotatool, a command-line quota utility.
Right now, I'm using BLOCK_SIZE -- defined in
<linux/fs.h> -- to convert between blocks and bytes.
I'd like to not use the linux header files at all for
this, but how else can I find the info?

   Please CC: me at mpg4@duluoz.net, as I'm not 
subscribed to the list.

-mike

-- 

GnuPG key available at http://devel.duluoz.net/pubkey.asc
Key ID = 1024D/9A256AE5 1999-11-13 Mike Glover <mpg4@duluoz.net>
Key fingerprint = EF6E 8BCB 4810 E98C F0FD  4596 367A 32B7 9A25 6AE5


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
