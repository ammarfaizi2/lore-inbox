Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbVIOUvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbVIOUvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVIOUvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:51:05 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:51730 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932597AbVIOUvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:51:04 -0400
To: Valdis.Kletnieks@vt.edu
Cc: David Lang <david.lang@digitalinsight.com>,
       Lee Revell <rlrevell@joe-job.com>, Hua Zhong <hzhong@gmail.com>,
       marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
	<6bffcb0e05091415533d563c5a@mail.gmail.com>
	<4328B710.5080503@in.tum.de>
	<200509151009.59981.marekw1977@yahoo.com.au>
	<924c288305091417375fea4ec2@mail.gmail.com>
	<Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz>
	<1126753444.13893.123.camel@mindpipe>
	<Pine.LNX.4.62.0509150313500.9384@qynat.qvtvafvgr.pbz>
	<87zmqextr5.fsf@amaterasu.srvr.nix>
	<200509152036.j8FKapjw025768@turing-police.cc.vt.edu>
From: Nix <nix@esperi.org.uk>
X-Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Date: Thu, 15 Sep 2005 21:50:48 +0100
In-Reply-To: <200509152036.j8FKapjw025768@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Thu, 15 Sep 2005 16:36:51 -0400")
Message-ID: <877jdixdg7.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005, Valdis Kletnieks murmured woefully:
> 1) This patch is pointless without other kernel magic to guarantee that
> even root can't open /dev/kmem - either SELinux and/or the 'devmem.patch'
> that's in current Fedora kernels.  There's well-known ways to do the equivalent of
> an insmod even if the kernel is built with 'CONFIG_MODULES=n'.

Agreed; I use it in conjunction with a one-liner to remove CAP_RAWIO
from the capability bounding set.

> 2) Guess it's time to re-post my sysctl patch to provide a general-purpose
> one-shot... (Diffed against 2.6.11-mm4, but applies cleanly to 2.6.13-mm1 as well).

Yes, much nicer. (My goal, to get a better patch by posting my ugly one,
is achieved! ;) )

-- 
`One cannot, after all, be expected to read every single word
 of a book whose author one wishes to insult.' --- Richard Dawkins
