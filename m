Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZA7Y>; Thu, 25 Jan 2001 19:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRAZA7P>; Thu, 25 Jan 2001 19:59:15 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:64265 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129169AbRAZA7E>; Thu, 25 Jan 2001 19:59:04 -0500
Date: Fri, 26 Jan 2001 01:59:01 +0100
From: Jan Niehusmann <jan@gondor.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010126015901.A19138@gondor.com>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <m3itn3i5iu.fsf@austin.jhcloos.com> <14960.50897.494908.316057@pizda.ninka.net> <20010126115057.A366@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126115057.A366@zip.com.au>; from cat@zip.com.au on Fri, Jan 26, 2001 at 11:50:57AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 11:50:57AM +1100, CaT wrote:
> I'm not sure as to what the problem with hotmail may be. I have ECN
> turned on:
> 
> gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
> 1
> 
> and I can contact hotmail just fine. I also can ftp to your site
> non-passively. where should I go to on hotmail to see it fail?

You may be located behind a firewall that zeroes out the ECN bits. This would
mean that hotmail doesn't get ECN packets and the connection gets established
just as if you were talking to a plain non-ECN server without a firewall.

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
