Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287330AbSACR2w>; Thu, 3 Jan 2002 12:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288272AbSACR2m>; Thu, 3 Jan 2002 12:28:42 -0500
Received: from ns.ithnet.com ([217.64.64.10]:50693 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287330AbSACR20>;
	Thu, 3 Jan 2002 12:28:26 -0500
Date: Thu, 3 Jan 2002 18:27:56 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: alan@lxorguk.ukuu.org.uk, akpm@zip.com.au, znmeb@aracnet.com,
        art@lsr.nei.nih.gov, linux-kernel@vger.kernel.org
Subject: Re: kswapd etc hogging machine
Message-Id: <20020103182756.237453bd.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0201031448410.24031-100000@imladris.surriel.com>
In-Reply-To: <E16M72b-0008B8-00@the-village.bc.nu>
	<Pine.LNX.4.33L.0201031448410.24031-100000@imladris.surriel.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 14:51:01 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

> On Thu, 3 Jan 2002, Alan Cox wrote:
> 
> > 2.4.1x VM code is performing better under light loads but its
> > absolutely and completely hopeless under a real paging load. 2.4.17-aa
> > is somewhat better interestingly.
> 
> A quick 'make -j bzImage' test I did yesterday got the system
> to use near 70% of its CPU time in user mode and 30% in system
> mode. This was with 2.4.17-rmap-10b, btw.

And what kind of an argument is this? This is an honest question, really. If I
do this make I end up around 80-90% in user mode and the rest in system on a
standard 2.4.17 SMP box (configured with too less swap btw).

???

Regards,
Stephan

