Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293642AbSCKIpi>; Mon, 11 Mar 2002 03:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293643AbSCKIp3>; Mon, 11 Mar 2002 03:45:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39100 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293642AbSCKIpP>;
	Mon, 11 Mar 2002 03:45:15 -0500
Date: Mon, 11 Mar 2002 00:42:00 -0800 (PST)
Message-Id: <20020311.004200.67678124.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015835388.1802.12.camel@monkey>
In-Reply-To: <20020310.173935.74819813.davem@redhat.com>
	<20020310.175858.21402963.davem@redhat.com>
	<1015835388.1802.12.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 11 Mar 2002 08:29:48 +0000

   Mar 11 08:22:57 monkey kernel: eth0: Link is up at 1000 Mbps, full-duplex.
   Mar 11 08:22:57 monkey kernel: eth0: Pause is disabled

Your switch doesn't support XON/XOFF pause? :(
That is the root cause for the RX overflows...

PLEASE STICK AROUND RIGHT NOW, I have new patches for you to test
and we can avoid the 24 hour turn around time for debugging this
if you don't disappear on me. :-)))
