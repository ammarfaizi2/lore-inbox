Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKFKrB>; Mon, 6 Nov 2000 05:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129038AbQKFKqv>; Mon, 6 Nov 2000 05:46:51 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:12018 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129033AbQKFKqh>; Mon, 6 Nov 2000 05:46:37 -0500
Message-ID: <3A068C00.272BD5D2@uow.edu.au>
Date: Mon, 06 Nov 2000 21:46:24 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: barryn@pobox.com, linux-kernel@vger.kernel.org, jamal <hadi@cyberus.ca>
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <200011060615.WAA05490@cx518206-b.irvn1.occa.home.com> <Pine.LNX.4.10.10011060113240.8248-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> I'm still not sure why it's been decided not to do fallback or how this
> whole situation is any different from path MTU discovery.

It has:

"Changes to make to the ECN RFC before it goes to proposed standard: 
     * If the TCP host receives no response to a SYN packet sent
       with the TCP ECN_ECHO and CWR flags set, to indicate
       ECN-capability, then the sender should send its second
       SYN packet without these flags set. This is because
       there are several deployed TCP implementations that
       don't respond to SYN packets with these ECN-related flags set"

	http://www.aciri.org/floyd/ecn.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
