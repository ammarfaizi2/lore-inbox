Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSGEHAM>; Fri, 5 Jul 2002 03:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSGEHAL>; Fri, 5 Jul 2002 03:00:11 -0400
Received: from monster.nni.com ([216.107.0.51]:27148 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S315472AbSGEHAL>;
	Fri, 5 Jul 2002 03:00:11 -0400
Date: Fri, 5 Jul 2002 03:02:32 -0400
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-Id: <20020705030232.2b47515f.arodland@noln.com>
In-Reply-To: <Pine.NEB.4.44.0207050840140.14934-100000@mimas.fachschaften.tu-muenchen.de>
References: <20020705021827.713e4cc6.arodland@noln.com>
	<Pine.NEB.4.44.0207050840140.14934-100000@mimas.fachschaften.tu-muenchen.de>
X-Mailer: Sylpheed version 0.7.6claws16 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002 08:56:59 +0200 (CEST)
Adrian Bunk <bunk@fs.tum.de> wrote:

> On Fri, 5 Jul 2002, Andrew Rodland wrote:
> 
> >...
> > Very nearly off topic, but I've had a few people on IRC tell me that
> > they love O(1) specifically because it has a 'nice that actually
> > does something'. As a matter of fact, I've had to change my X
> > startup scripts, to make it a bit less selfish; the defaults are
> > just plain silly, now.
> >...
> 
> This is exactly a reason why O(1) shouldn't go into 2.4:
> 
> E.g. my X is as suggested by my the installation routine of my
> distribution (Debian unstable/testing) niced to -10. It would be a bad
> surprise for _many_ people if they upgrade their 2.4 kernel because of
> other security and/or stability fixes and such a setting is then
> wrong.
> 

Same setup, actually -- I changed it to -3 and it seems nicer.

As for it going into 2.4, well, I'm not incredibly strongly for it, but
I do get a feeling that most of the distros (especially the ones famous
for patching their kernels beyond recognizabliity) will start jumping on
this particular wagon soon. Does the kernel want to be like debian
("Well, yeah, the releases are horribly out of date, but normal human
beings don't actually _use_ the releases") ?

P.S. Do not suppose from this message that I do not love debian
immensely. :)
