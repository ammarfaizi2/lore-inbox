Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRGWXnq>; Mon, 23 Jul 2001 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbRGWXng>; Mon, 23 Jul 2001 19:43:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13446 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265193AbRGWXnU>;
	Mon, 23 Jul 2001 19:43:20 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.46734.280781.653712@pizda.ninka.net>
Date: Mon, 23 Jul 2001 16:43:10 -0700 (PDT)
To: Andrew Friedley <saai@swbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pppoe patch in 2.4.7 results - still problem
In-Reply-To: <000901c112d6$a1a30000$0200a8c0@loki>
In-Reply-To: <000901c112d6$a1a30000$0200a8c0@loki>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Andrew Friedley writes:
 > In response to the pppoe patch to try to fix panics with pppoe and smp:
 > When running napster/napigator from a windows machine on my LAN, the router
 > running 2.4.7 still panics.  It has not been long enough to tell if the
 > "random" panics have been fixed for sure, but so far, so good - 1 day, 4
 > hour uptime right now.  Here is a paste of a napster-induced panic with
 > kernel 2.4.7 followed by the ksymoops output.

This looks like perhaps a specific problem with the 8139too
patches to support single-copy checksumming.  I could be wrong,
but it looks nothing like the pppoe OOPS traces.

Later,
David S. Miller
davem@redhat.com
