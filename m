Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263496AbRFANU2>; Fri, 1 Jun 2001 09:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263497AbRFANUS>; Fri, 1 Jun 2001 09:20:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59522 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263496AbRFANUL>;
	Fri, 1 Jun 2001 09:20:11 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15127.38509.495537.405210@pizda.ninka.net>
Date: Fri, 1 Jun 2001 06:19:41 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <3B179579.F9C9C721@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0106011503030.18082-100000@kenzo.iwr.uni-heidelberg.de>
	<3B179579.F9C9C721@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > For your HA application specifically, right now, I would suggest making
 > sure your net driver calls netif_carrier_xxx correctly, then checking
 > for IFF_RUNNING interface flag.  IFF_RUNNING will disappear if the
 > interface is up, but there is no carrier [as according to
 > netif_carrier_ok].

Don't such HA apps need to run as root anyways?

Regardless, I agree that, long term, the way to do this is via netlink.

Later,
David S. Miller
davem@redhat.com
