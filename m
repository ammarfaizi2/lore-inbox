Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289365AbSAVTYK>; Tue, 22 Jan 2002 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSAVTYB>; Tue, 22 Jan 2002 14:24:01 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58118 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289368AbSAVTXq>; Tue, 22 Jan 2002 14:23:46 -0500
Subject: Re: Linux 2.4.18-pre5
From: Tommy Faasen <faasen@xs4all.nl>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0201221552030.2059-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0201221552030.2059-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 20:27:26 +0100
Message-Id: <1011727647.379.1.camel@it0>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 18:53, Marcelo Tosatti wrote:

Damned there goes my uptime
it0@it0:~$ uptime
 20:26:16 up 1 min,  1 user,  load average: 0.23, 0.10, 0.04
it0@it0:~$ uname -a
Linux it0 2.4.18-pre5 #1 Tue Jan 22 20:12:29 CET 2002 i686 unknown


> 
> Argh. Another mistake. 
> 
> DO NOT USE pre5: It has a "fix" from Andi Kleen for the icmp problem which
> does not exist. Its really not needed and causes problems.
> 
> I'll release a pre6 now.
> 
> Shoot me.
> 
> On 22 Jan 2002, Alex Romosan wrote:
> 
> > Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> > 
> > > On 22 Jan 2002, Alex Romosan wrote:
> > > 
> > > > Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> > > > 
> > > > > Well, here goes pre5.
> > > > > 
> > > > > 
> > > > 
> > > > this patch seems to be generated against pre4, not 2.4.17. just a
> > > > heads up.
> > > 
> > > Eeek. Right.
> > > 
> > > I've just uploaded a new patch on top of the old one. 
> > 
> > the two patches are not quite equivalent. if i now try to reverse the
> > patch i get two failures:
> > 
> > patching file net/ipv4/icmp.c
> > Hunk #3 FAILED at 495.
> > 1 out of 3 hunks FAILED -- saving rejects to file net/ipv4/icmp.c.rej
> > patching file net/ipv4/ipconfig.c
> > patching file net/ipv4/netfilter/ip_conntrack_standalone.c
> > patching file net/ipv6/icmp.c
> > Unreversed patch detected!  Ignore -R? [n] 
> > Apply anyway? [n] 
> > Skipping patch.
> > 1 out of 1 hunk ignored -- saving rejects to file net/ipv6/icmp.c.rej
> > patching file net/ipv6/tcp_ipv6.c
> > 
> > i think i'll download a pristine 2.4.17 and start again.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


