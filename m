Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278053AbRJIXC4>; Tue, 9 Oct 2001 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277264AbRJIXCq>; Tue, 9 Oct 2001 19:02:46 -0400
Received: from Expansa.sns.it ([192.167.206.189]:35346 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278053AbRJIXCb>;
	Tue, 9 Oct 2001 19:02:31 -0400
Date: Wed, 10 Oct 2001 01:02:45 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Trever L. Adams" <trever_adams@yahoo.com>
cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <1002667785.4093.13.camel@aurora>
Message-ID: <Pine.LNX.4.33.0110100059590.24292-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and what is the content of
/proc/net/ip_conntrack
file?

how big is the buffer you are using for packet tracing?
(/proc/sys/net/ipv4/ip_conntrack_max)


On 9 Oct 2001, Trever L. Adams wrote:

> On Tue, 2001-10-09 at 18:46, Luigi Genoni wrote:
> > stupid question...
> > have you got a rule like
> >
> > iptables -A INPUT -m unclean -j DROP
> >
> > enabled?
>
> I do not know what unclean means, so I don't know.
>
> I have one that only accepts NEW from the inside.
> I have one that accepts all ESTABLISHED,RELATED.
> I have one that drops NEW,INVALID from ppp0 (outside world).
>
> Trever
>
>
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
>

