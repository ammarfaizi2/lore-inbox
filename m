Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289353AbSAVTGm>; Tue, 22 Jan 2002 14:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289360AbSAVTEh>; Tue, 22 Jan 2002 14:04:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18955 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289355AbSAVTEY>; Tue, 22 Jan 2002 14:04:24 -0500
Date: Tue, 22 Jan 2002 15:53:21 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre5
In-Reply-To: <87hepedxgx.fsf@sycorax.lbl.gov>
Message-ID: <Pine.LNX.4.21.0201221552030.2059-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Argh. Another mistake. 

DO NOT USE pre5: It has a "fix" from Andi Kleen for the icmp problem which
does not exist. Its really not needed and causes problems.

I'll release a pre6 now.

Shoot me.

On 22 Jan 2002, Alex Romosan wrote:

> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> > On 22 Jan 2002, Alex Romosan wrote:
> > 
> > > Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> > > 
> > > > Well, here goes pre5.
> > > > 
> > > > 
> > > 
> > > this patch seems to be generated against pre4, not 2.4.17. just a
> > > heads up.
> > 
> > Eeek. Right.
> > 
> > I've just uploaded a new patch on top of the old one. 
> 
> the two patches are not quite equivalent. if i now try to reverse the
> patch i get two failures:
> 
> patching file net/ipv4/icmp.c
> Hunk #3 FAILED at 495.
> 1 out of 3 hunks FAILED -- saving rejects to file net/ipv4/icmp.c.rej
> patching file net/ipv4/ipconfig.c
> patching file net/ipv4/netfilter/ip_conntrack_standalone.c
> patching file net/ipv6/icmp.c
> Unreversed patch detected!  Ignore -R? [n] 
> Apply anyway? [n] 
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file net/ipv6/icmp.c.rej
> patching file net/ipv6/tcp_ipv6.c
> 
> i think i'll download a pristine 2.4.17 and start again.

