Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131385AbRAYLd5>; Thu, 25 Jan 2001 06:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131723AbRAYLds>; Thu, 25 Jan 2001 06:33:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7558 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131631AbRAYLdb>;
	Thu, 25 Jan 2001 06:33:31 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.3804.197814.496909@pizda.ninka.net>
Date: Thu, 25 Jan 2001 03:32:44 -0800 (PST)
To: Andi Kleen <ak@suse.de>
Cc: kuznet@ms2.inr.ac.ru, Manfred Spraul <manfred@colorfullife.COM>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
In-Reply-To: <20010124215634.A2992@gruyere.muc.suse.de>
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com>
	<200101242003.XAA21040@ms2.inr.ac.ru>
	<20010124215634.A2992@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > It's mostly for security to make it more difficult to nuke connections
 > without knowing the sequence number.
 > 
 > Remember RFC is from a very different internet with much less DoS attacks.

Andi, one of the worst DoSs in the world is not being able to
communicate with half of the systems out there.

BSD and Solaris both make these kinds of packets, therefore it is must
to handle them properly.  So we will fix Linux, there is no argument.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
