Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUFTM4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUFTM4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 08:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFTM4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 08:56:07 -0400
Received: from [195.255.196.126] ([195.255.196.126]:4318 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S264850AbUFTM4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 08:56:02 -0400
Date: Sun, 20 Jun 2004 15:56:01 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: David Lang <david.lang@digitalinsight.com>
Cc: Valdis.Kletnieks@vt.edu, 4Front Technologies <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness 
In-Reply-To: <Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
 <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de>
 <40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int><40D34CB2.10900@opensound.com>
 <200406181940.i5IJeBDh032311@turing-police.cc.vt.edu>
 <Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, David Lang wrote:

> by the way there's useually a *version file in /etc that tells you what
> version of a particular distro you are running on (or at least what it was
> before it got tweaked)
It's usually possible to figure out the distribution and version by
looking at /etc/issue. However it's impossible to figure out who has made
the kernel image. It's possible to identify Mandrake kernels and few
others. However in general all kernel versions look the same.

There are about 10 major Linux distributions (for i386) and nobody knows
how many minor ones. In addition each of them has multiple versions (still
in use by potential customers). In addition it's possible that the system
is running some different kernel than the distribution one (such as a
kernel.org one or some special purpose one).

The current situation is that every company who like to ship open source
drivers with their hardware will have to automatically detect large
amount of kernel and distribution combinations and try to decide which
kind of installation approach is needed. After everything is settled then
some distribution changes it's interfaces and the circus begins once
again. Finally when a change is made to the installation procedure then
how to test if it still works with all 100 or 200 different systems and
kernel images that have already been tested during past years.

I think many persons reading this list don't realize that a significant
number of Linux installations are still using 7.x or even 6.x versions of
whatever distribution they had originally installed in the system.
Companies doing Linux software (be it open source or closed source) need
to support them in addition to the state of the art distributions. So
would it be too much to ask that kernels based on the same major version
do certain things in the same way.

Does anybody have ever tried to install any open source drivers that are
not included in the kernel source tree yet?

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
