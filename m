Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbREEX2W>; Sat, 5 May 2001 19:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135593AbREEX2N>; Sat, 5 May 2001 19:28:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37783 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135590AbREEX1x>;
	Sat, 5 May 2001 19:27:53 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15092.35947.527339.828149@pizda.ninka.net>
Date: Sat, 5 May 2001 16:27:39 -0700 (PDT)
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <Pine.LNX.4.33.0105051556280.20277-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0105051550000.20277-100000@twinlark.arctic.org>
	<Pine.LNX.4.33.0105051556280.20277-100000@twinlark.arctic.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dean gaudet writes:
 > also -- isn't it kind of wrong for arp to respond with addresses from
 > other interfaces?
 > 
 > what if ip_forward is 0?  or if there's some other sort of routing policy
 > in effect?

This along with some other issues are why Alexey and myself want to
do ARP filter in some other way.

There are two sides to this story though, both with valid arguments.

Ho hum... since things have settled down in the networking and this
is being pushed again, I guess it's time to fire up the dialogue
once more.

Later,
David S. Miller
davem@redhat.com
