Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRAaSCl>; Wed, 31 Jan 2001 13:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbRAaSCb>; Wed, 31 Jan 2001 13:02:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14089 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129811AbRAaSCV>; Wed, 31 Jan 2001 13:02:21 -0500
Subject: Re: ECN: Clearing the air (fwd)
To: greg@linuxpower.cx (Gregory Maxwell)
Date: Wed, 31 Jan 2001 18:02:17 +0000 (GMT)
Cc: jas88@cam.ac.uk (James Sutherland), hadi@cyberus.ca (jamal),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010128144204.B13195@xi.linuxpower.cx> from "Gregory Maxwell" at Jan 28, 2001 02:42:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O1aF-0002nY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. ECN is essential to the continued stability of the Internet. Without
> probabilistic queuing (i.e. RED) and ECN the Internet will continue to have
> retransmit synchronization and once congested stay congested until people get
> frustrated and give it up for a little bit.

Arguably so. In theory a vindictive probabilistic queueing is sufficient
(do RED but then drop -every- frame from the same route as the packet chosen
 from the queue)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
