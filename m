Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264427AbRFOPjQ>; Fri, 15 Jun 2001 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264429AbRFOPjH>; Fri, 15 Jun 2001 11:39:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57274 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264427AbRFOPiz>;
	Fri, 15 Jun 2001 11:38:55 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15146.11272.896877.462646@pizda.ninka.net>
Date: Fri, 15 Jun 2001 08:38:48 -0700 (PDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <Pine.LNX.4.05.10106151041590.32503-100000@callisto.of.borg>
In-Reply-To: <15145.3254.105970.424506@pizda.ninka.net>
	<Pine.LNX.4.05.10106151041590.32503-100000@callisto.of.borg>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geert Uytterhoeven writes:
 > Well, those resource conflicts shouldn't be there in the first place. They
 > should be handled by the OS.

I agree, completely.

But this doesn't solve the issue of reserving resources inside the
X server.  Ie. making sure one driver doesn't take the register area
another driver is using.

You still need to get the controller number into the resources to do
that properly.

Later,
David S. Miller
davem@redhat.com
