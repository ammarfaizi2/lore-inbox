Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278061AbRJIXkL>; Tue, 9 Oct 2001 19:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277263AbRJIXkB>; Tue, 9 Oct 2001 19:40:01 -0400
Received: from Expansa.sns.it ([192.167.206.189]:61202 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278059AbRJIXjq>;
	Tue, 9 Oct 2001 19:39:46 -0400
Date: Wed, 10 Oct 2001 01:40:09 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <Pine.LNX.4.33.0110091604250.15092-100000@windmill.gghcwest.com>
Message-ID: <Pine.LNX.4.33.0110100136280.24989-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the buffer is big enought for your traffic, I suppose.

I saw something similar to your report, but indeed the buffer was too
small.

A good thing would be to see a packet dropped and the entries in
/proc/net/ip_conntrack, so that it will be possible to infer something.

with 2.4.10 i see packet tracing working very well also under
eavy network loads if the buffer is big enought...

and you are not using the controvers unclean module...

On Tue, 9 Oct 2001, Jeffrey W. Baker wrote:

>
>
> On Wed, 10 Oct 2001, Luigi Genoni wrote:
>
> > and what is the content of
> > /proc/net/ip_conntrack
> > file?
> >
> > how big is the buffer you are using for packet tracing?
> > (/proc/sys/net/ipv4/ip_conntrack_max)
>
> Well, I'm not going to send that file to the Internet at large, but
> ip_conntrack current has about 2100 lines and the max is 65535.
>
> -jwb
>

