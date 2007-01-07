Return-Path: <linux-kernel-owner+w=401wt.eu-S932550AbXAGOcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbXAGOcL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbXAGOcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:32:11 -0500
Received: from 1wt.eu ([62.212.114.60]:1835 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932550AbXAGOcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:32:10 -0500
Date: Sun, 7 Jan 2007 15:32:05 +0100
From: Willy Tarreau <w@1wt.eu>
To: Akula2 <akula2.shark@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
Message-ID: <20070107143205.GB435@1wt.eu>
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com> <459D9872.8090603@foo-projects.org> <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com> <20070107093057.GS24090@1wt.eu> <8355959a0701070511v55c671dibc3bb7d4426129e0@mail.gmail.com> <20070107132054.GA435@1wt.eu> <8355959a0701070619w19dd79a5r5ccfdd1121e6a52b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0701070619w19dd79a5r5ccfdd1121e6a52b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC list trimmed since I'm repeating myself ]

On Sun, Jan 07, 2007 at 07:49:05PM +0530, Akula2 wrote:
> >> On 1/7/07, Willy Tarreau <w@1wt.eu> wrote:
> >I don't see which libs you are talking about. The compiler you build your
> >kernel with is totally independant on the compiler you build your apps 
> >with.
> >A few years ago, some distros even shipped a compiler just for the kernel
> >(they called the binary "kgcc").
> >
> >So you just have to build 2 different GCC, one for 2.4, one for 2.6 and
> >you use them to build your kernels. If you want yet another compiler for
> >your apps, simply do it, it's not a problem. For instance, look on my
> >system when I type gcc- <Tab> :
> 
> Sorry for the typo & confusion caused. I meant in that example as:-
> 
> myArmWireless app. compiled with gcc-3.4.x, NOT gcc-4.1.x compiler on
> say 2.4.34 kernel (assuming I can build 4.1.x on 2.4.34 kernel).
> 
> Now, I've got it about this app funda. Ok! Am coming closer now. I
> have these 2 tasks:-
> 
> a) Since 2.6 kernel has no issues with gcc-3.4.x, gcc-4.1.x. So I will
> build them. No probs here.
> 
> b) 2.4 kernel has no issues with gcc-3.4.x to my understanding, but am
> not sure about compiling it with gcc-4.1.x? If this is true, how to
> build this?

As I already explained in another mail, 2.4.34 builds with gcc-4.1 on x86
and a few other archs. I also explained how to do this :

$ make CC=gcc-4.1

I don't know how I can explain it to you an easier way, but what I'm sure
about is that if you are having such big trouble understanding simple
commands like this, you will certainly encounter many more when building
your own distro.

> Whole idea is to have 2 compilers (gcc-3.4.x, gcc-4.1.x) on the both
> the kernels.

That's what I understood and the need I replied too the first time.

Willy

