Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbTC0P7A>; Thu, 27 Mar 2003 10:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbTC0P6v>; Thu, 27 Mar 2003 10:58:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263152AbTC0P6t>;
	Thu, 27 Mar 2003 10:58:49 -0500
Date: Thu, 27 Mar 2003 08:06:27 -0800 (PST)
Message-Id: <20030327.080627.71980411.davem@redhat.com>
To: shmulik.hen@intel.com
Cc: bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [Bonding][patch] Adding Transmit load balancing mode to bonding
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303271705580.7106-100000@jrslxjul4.npdj.intel.com>
References: <Pine.LNX.4.44.0303271705580.7106-100000@jrslxjul4.npdj.intel.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: shmulik.hen@intel.com
   Date: Thu, 27 Mar 2003 17:38:02 +0200 (IST)

   Balancing is connection oriented (e.g. by IPv4 destination address)
   so packet order is always kept.

You could also key off of the destination/source port as well for
UDP/TCP/SCTP.  Have you experimented with this?
