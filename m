Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264011AbRFNUPQ>; Thu, 14 Jun 2001 16:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264015AbRFNUPG>; Thu, 14 Jun 2001 16:15:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33715 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264011AbRFNUOs>;
	Thu, 14 Jun 2001 16:14:48 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.6960.267459.725096@pizda.ninka.net>
Date: Thu, 14 Jun 2001 13:14:40 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B2919B8.85D38801@mandrakesoft.com>
In-Reply-To: <15145.1739.395626.842663@pizda.ninka.net>
	<200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
	<15145.3254.105970.424506@pizda.ninka.net>
	<3B29137B.CA8442B8@mandrakesoft.com>
	<15145.5939.879723.656331@pizda.ninka.net>
	<3B2919B8.85D38801@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > ok with me.  would bus #0 be the system or root bus?  that would be my
 > preference, in a tiered system like this.

Bus 0 is controller 0, of whatever bus type that happens to be.
If we want to do something special we could create something
like /proc/bus/root or whatever, but I feel this unnecessary.

Later,
David S. Miller
davem@redhat.com
