Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131621AbRA3AtP>; Mon, 29 Jan 2001 19:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbRA3Asz>; Mon, 29 Jan 2001 19:48:55 -0500
Received: from m67-mp1-cvx1b.col.ntl.com ([213.104.72.67]:30725 "EHLO
	[213.104.72.67]") by vger.kernel.org with ESMTP id <S131568AbRA3Asr>;
	Mon, 29 Jan 2001 19:48:47 -0500
To: "Jamie Lokier" <ln@tantalophile.demon.co.uk>
Cc: "Andi Kleen" <ak@muc.de>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        <paulus@linuxcare.com>, <linux-ppp@vger.kernel.org>,
        <linux-net@vger.kernel.org>
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
In-Reply-To: <m2d7d838sj.fsf@boreas.yi.org.>
	<200101290245.f0T2j2Y438757@saturn.cs.uml.edu>
	<20010129135905.B1591@fred.local>
	<20010129193136.A11035@pcep-jamie.cern.ch>
From: "John Fremlin" <vii@altern.org>
Date: 30 Jan 2001 00:47:04 +0000
In-Reply-To: Jamie Lokier's message of "Mon, 29 Jan 2001 19:31:36 +0100"
Message-ID: <m2zog9sw6v.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <ln@tantalophile.demon.co.uk> writes:

[...]

> The important thing is that the tunnel is destroyed and recreated
> (it has to be, it is over different underlying link addresses).  I
> do not want that to destroy the connections from the tunnelled
> address.

No connections at all will be destroyed by my patch unless you enable
the new killoldaddr pppd option.

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
