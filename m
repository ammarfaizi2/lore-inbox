Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264282AbRFOJJb>; Fri, 15 Jun 2001 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRFOJJV>; Fri, 15 Jun 2001 05:09:21 -0400
Received: from Expansa.sns.it ([192.167.206.189]:56587 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264282AbRFOJJL>;
	Fri, 15 Jun 2001 05:09:11 -0400
Date: Fri, 15 Jun 2001 11:08:51 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Andi Kleen <ak@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>, <jfs-discussion@oss.lotus.com>
Subject: Re: [Jfs-discussion] Re: severe FS corruption with 2.4.6-pre2 + IBM
 jfs 0.3.4 patch
In-Reply-To: <20010615085539.B23145@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0106151105080.32257-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Andi Kleen wrote:

> rm -rf not working correctly is a kind of show stopper bug ATM though.
> Hopefully it can be fixed soon.

with too many files inside of a directory this was a bug also under
AIX 3.2.5, and could be used for any kind of DoS.
Just with AIX 4.1.X this bug disappeared and we also got the
possibility to use a block size smaller than 1024

Luigi




