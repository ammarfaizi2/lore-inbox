Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbQJaEYV>; Mon, 30 Oct 2000 23:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQJaEYL>; Mon, 30 Oct 2000 23:24:11 -0500
Received: from caperry-pc1.isot.com ([208.27.64.66]:32394 "HELO
	onramp.southern-star-ranch.com") by vger.kernel.org with SMTP
	id <S130196AbQJaEYA>; Mon, 30 Oct 2000 23:24:00 -0500
Message-ID: <39FE5E75.91BEBD0@edolnx.net>
Date: Mon, 30 Oct 2000 23:53:57 -0600
From: Carl Perry <caperry@edolnx.net>
Reply-To: caperry@edolnx.net
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Is IPv4 totally broken in 2.4-test
In-Reply-To: <39FE5C09.F1B13725@edolnx.net> <200010310404.UAA05392@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duh.  And here I was thinking that was a good thing.  That did it.  What exactly
does "Explicit Congestion Notification" do?  I figured it was going to put a
message in syslog if the wire is full and packets were being dropped.  There
weren't any docs in menuconfig - so I figured "what the hey?".  Boy - I was
wrong.  Thanks for the quick response.  I haven't even gotten the post back yet.

"David S. Miller" wrote:
> 
> echo "0" >/proc/sys/net/ipv4/tcp_ecn
> 
> Or don't enable CONFIG_INET_ECN in your kernel configuration.
> 
> Later,
> David S. Miller
> davem@redhat.com

-- 
	-Carl Perry
	caperry@edolnx.net

"Real programmers don't draw flowcharts.  Flowcharts are, after
all, the illiterate's form of documentation.  Cavemen drew
flowcharts; look how much good it did them."
	-Fortune (The App, not the Magazine)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
