Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289351AbSAVS7A>; Tue, 22 Jan 2002 13:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289352AbSAVS6v>; Tue, 22 Jan 2002 13:58:51 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:21134 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S289351AbSAVS6e>;
	Tue, 22 Jan 2002 13:58:34 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre5
In-Reply-To: <Pine.LNX.4.21.0201221538310.2059-100000@freak.distro.conectiva>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: 22 Jan 2002 10:58:22 -0800
In-Reply-To: <Pine.LNX.4.21.0201221538310.2059-100000@freak.distro.conectiva> (message from Marcelo Tosatti on Tue, 22 Jan 2002 15:40:57 -0200 (BRST))
Message-ID: <87hepedxgx.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On 22 Jan 2002, Alex Romosan wrote:
> 
> > Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> > 
> > > Well, here goes pre5.
> > > 
> > > 
> > 
> > this patch seems to be generated against pre4, not 2.4.17. just a
> > heads up.
> 
> Eeek. Right.
> 
> I've just uploaded a new patch on top of the old one. 

the two patches are not quite equivalent. if i now try to reverse the
patch i get two failures:

patching file net/ipv4/icmp.c
Hunk #3 FAILED at 495.
1 out of 3 hunks FAILED -- saving rejects to file net/ipv4/icmp.c.rej
patching file net/ipv4/ipconfig.c
patching file net/ipv4/netfilter/ip_conntrack_standalone.c
patching file net/ipv6/icmp.c
Unreversed patch detected!  Ignore -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file net/ipv6/icmp.c.rej
patching file net/ipv6/tcp_ipv6.c

i think i'll download a pristine 2.4.17 and start again.

--alex--


-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
