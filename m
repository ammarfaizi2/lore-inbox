Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbSKGJJb>; Thu, 7 Nov 2002 04:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266413AbSKGJJb>; Thu, 7 Nov 2002 04:09:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52374 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266411AbSKGJJa>;
	Thu, 7 Nov 2002 04:09:30 -0500
Date: Thu, 07 Nov 2002 01:15:26 -0800 (PST)
Message-Id: <20021107.011526.120464470.davem@redhat.com>
To: randy.dunlap@verizon.net
Cc: linux-kernel@vger.kernel.org, ahu@ds9a.nl
Subject: Re: Silly advise in bridge Configure help
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DC9EA2A.142559AA@verizon.net>
References: <3DC9EA2A.142559AA@verizon.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Randy.Dunlap" <randy.dunlap@verizon.net>
   Date: Wed, 06 Nov 2002 20:20:58 -0800
   
   Sounds good, so here's the patch to 2.5.46 Kconfig to do that
   if you want it.

I had a similar patch in my queue from Lennert Buytenhek (written by
Bart De Schuyer) which I'm about to send to Linus.

[BRIDGE] update help docs

--- linux-2.5.45/net/Kconfig	Thu Oct 31 01:41:43 2002
+++ linux-2.5.45-bezig/net/Kconfig	Sat Nov  2 12:25:21 2002
@@ -382,10 +382,10 @@
 	  for location. Please read the Bridge mini-HOWTO for more
 	  information.
 
-	  Note that if your box acts as a bridge, it probably contains several
-	  Ethernet devices, but the kernel is not able to recognize more than
-	  one at boot time without help; for details read the Ethernet-HOWTO,
-	  available from in <http://www.linuxdoc.org/docs.html#howto>.
+	  If you enable iptables support along with the bridge support then you
+	  turn your bridge into a bridging firewall.
+	  iptables will then see the IP packets being bridged, so you need to
+	  take this into account when setting up your firewall rules.
 
 	  If you want to compile this code as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
