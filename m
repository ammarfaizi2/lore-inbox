Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266698AbRGTH2w>; Fri, 20 Jul 2001 03:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGTH2m>; Fri, 20 Jul 2001 03:28:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33154 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266682AbRGTH2e>;
	Fri, 20 Jul 2001 03:28:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15191.56739.635100.533146@pizda.ninka.net>
Date: Fri, 20 Jul 2001 00:28:35 -0700 (PDT)
To: bj@zuto.de
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <20010720091329.B16207@zuto.de>
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
	<15189.2408.59953.395204@pizda.ninka.net>
	<20010720091329.B16207@zuto.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Rainer Clasen writes:
 > I am using tulip, dummy, Ben Grear's dot1q VLAN devices and some ISDN
 > syncppp and ISDN rawip devices are configured (but not actively used),
 > too.

Can you test without dummy and VLAN?  Man, I now have to audit that
friggin' code too :-(

Later,
David S. Miller
davem@redhat.com
