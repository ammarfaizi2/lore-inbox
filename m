Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAUCZE>; Sat, 20 Jan 2001 21:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131816AbRAUCY4>; Sat, 20 Jan 2001 21:24:56 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:51601 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S129692AbRAUCYm>;
	Sat, 20 Jan 2001 21:24:42 -0500
Date: Sat, 20 Jan 2001 21:24:39 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and ipmasq modules
In-Reply-To: <20010120144616.A16843@vitelus.com>
Message-ID: <Pine.SGI.4.31L.02.0101202123480.1807709-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Aaron Lehmann wrote:

> It was great to see that 2.4.0 reintroduced ipfwadm support! I had no
> need for ipchains and ended up using the wrapper around it that
> emulated ipfwadm. However, 2.[02].x used to have "special IP
> masquerading modules" such as ip_masq_ftp.o, ip_masq_quake.o, etc. I
> can't find these in 2.4.0. Where have they gone? Without important
> modules such as ip_masq_ftp.o I cannot use non-passive ftp from behind
> the masquerading firewall.

I think its ip_conntrack_ftp, but I'll check my fw setup to verify if you
still can't find it.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
