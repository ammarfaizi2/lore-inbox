Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136299AbREHDaF>; Mon, 7 May 2001 23:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbREHDaB>; Mon, 7 May 2001 23:30:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40620 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136299AbREHD3a>;
	Mon, 7 May 2001 23:29:30 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.26644.491818.92403@pizda.ninka.net>
Date: Mon, 7 May 2001 20:29:24 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072240581.7685-100000@freak.distro.conectiva>
In-Reply-To: <15095.25990.868966.309506@pizda.ninka.net>
	<Pine.LNX.4.21.0105072240581.7685-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > > Hmmm, can't this happen without my patch?
 > 
 > No. We will never call writepage() without __GFP_IO without your patch.
 > 

I see, because launder_loop never progresses to 1 in that case.

My patch is crap and can cause corruptions, there is not argument
about it now :-)

Later,
David S. Miller
davem@redhat.com
