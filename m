Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288261AbSACQxJ>; Thu, 3 Jan 2002 11:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288257AbSACQvf>; Thu, 3 Jan 2002 11:51:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:32783 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288256AbSACQvQ>;
	Thu, 3 Jan 2002 11:51:16 -0500
Date: Thu, 3 Jan 2002 14:51:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, "M. Edward Borasky" <znmeb@aracnet.com>,
        Art Hays <art@lsr.nei.nih.gov>, <linux-kernel@vger.kernel.org>
Subject: Re: kswapd etc hogging machine
In-Reply-To: <E16M72b-0008B8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0201031448410.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Alan Cox wrote:

> 2.4.1x VM code is performing better under light loads but its
> absolutely and completely hopeless under a real paging load. 2.4.17-aa
> is somewhat better interestingly.

A quick 'make -j bzImage' test I did yesterday got the system
to use near 70% of its CPU time in user mode and 30% in system
mode. This was with 2.4.17-rmap-10b, btw.

Though I have to admit the rmap patches should be considered
experimental, the last one does seem to survive some loads
where the standard kernel falls over ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

