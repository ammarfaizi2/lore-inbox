Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBDq>; Thu, 25 Jan 2001 20:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRAZBDh>; Thu, 25 Jan 2001 20:03:37 -0500
Received: from gatekeeper.gozer.weebeastie.net ([61.8.7.91]:36868 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129169AbRAZBDd>; Thu, 25 Jan 2001 20:03:33 -0500
Date: Fri, 26 Jan 2001 12:03:12 +1100
From: CaT <cat@zip.com.au>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010126120312.C366@zip.com.au>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <m3itn3i5iu.fsf@austin.jhcloos.com> <14960.50897.494908.316057@pizda.ninka.net> <20010126115057.A366@zip.com.au> <20010126015901.A19138@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126015901.A19138@gondor.com>; from jan@gondor.com on Fri, Jan 26, 2001 at 01:59:01AM +0100
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 01:59:01AM +0100, Jan Niehusmann wrote:
> On Fri, Jan 26, 2001 at 11:50:57AM +1100, CaT wrote:
> > gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
> > 1
> > 
> > and I can contact hotmail just fine. I also can ftp to your site
> > non-passively. where should I go to on hotmail to see it fail?
> 
> You may be located behind a firewall that zeroes out the ECN bits. This would
> mean that hotmail doesn't get ECN packets and the connection gets established
> just as if you were talking to a plain non-ECN server without a firewall.

gozer IS my firewall. :) beyond it is a modem and a dailup point, my ISPs
LAN and then the innanet. and I tried from it and from a box behind it.
I connected to hotmail just fine.

still, any way to test if the ECN bits are going through just fine?

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
