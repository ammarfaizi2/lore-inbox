Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268428AbRGXSpB>; Tue, 24 Jul 2001 14:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268430AbRGXSou>; Tue, 24 Jul 2001 14:44:50 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:20360 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S268428AbRGXSoo>; Tue, 24 Jul 2001 14:44:44 -0400
Date: Tue, 24 Jul 2001 11:44:35 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: <linux-kernel@vger.kernel.org>
Subject: adaptec aha152x.o stops working with AVA-1505 on 2.4.7
In-Reply-To: <Pine.LNX.4.33L.0107241521130.20326-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107241136280.23921-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I compiled aha152x as a module and usually have it load at boot. However,
with kernel 2.4.7, the machine hangs in some in-between state when the
module is loaded. No oops or panic is printed -- the machine simply hangs
and does nothing. The keyboard is responsive however but it appears as
though nothing gets through to the kernel.

Furthermore, nothing is printed in the logs about any such error. I'm
wondering if this is somehow related to the recent SCSI layer cleanups?

The machine is an SMP Pentium III with 640 megabytes of RAM. If you need
any more details, e.g. .config, lspci, etc. let me know and I'll provide
them. For the moment, I have removed the controller card from the machine
simply because it was pissing me off to no extent and I didn't want to
deal with it any longer. Fortunately, the only device connected to it is
an optical disk drive that gets very infrequent use, so I can live without
it, for a while.

LMK what you come up with. TIA,

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

