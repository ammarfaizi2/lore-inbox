Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSE3PFu>; Thu, 30 May 2002 11:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSE3PFt>; Thu, 30 May 2002 11:05:49 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:24325 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316678AbSE3PFt>; Thu, 30 May 2002 11:05:49 -0400
Date: Thu, 30 May 2002 17:05:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Message-ID: <20020530150505.GA6915@louise.pinerecords.com>
In-Reply-To: <UTC200205300019.g4U0JtH24034.aeb@smtp.cwi.nl> <3CF622F0.4050304@evision-ventures.com> <1022772774.12888.380.camel@irongate.swansea.linux.org.uk> <3CF62F2A.6030009@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9/sparc SMP
X-Uptime: 19:33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Thu, 2002-05-30 at 14:02, Martin Dalecki wrote:
> >
> >>1. util-linux doesn't cover half of the system utilities needed on
> >>   a sanely actual Linux system.
> >>2. The Linux vendors have to apply insane number of patches to it
> >>   util it's moderately usable.
> >
> >So now you have nothing better to do than insult someone whose code
> >works, is shipped in just about every distribution. Someone whose kernel
> >patches are almost without fail perfect first time.
> >
> >You should learn from Andries not mock him.
> 
> rpm -i util-linux-xxx.src.rpm

... tells you exactly nothing, because redhat people would even patch
/bin/true if it could be made to do anything extra.

util-linux build procedure from SlackBuild in slackware-current:

tar xjvf $CWD/util-linux-$VERSION.tar.bz2
cd util-linux-$VERSION
zcat $CWD/util-linux.MCONFIG.diff.gz | patch -E --backup -p1 --suffix=.orig
./configure
make
<snip>

T.
