Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUHDXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUHDXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUHDXuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:50:52 -0400
Received: from [203.178.140.15] ([203.178.140.15]:3338 "EHLO yue.st-paulia.net")
	by vger.kernel.org with ESMTP id S267516AbUHDXuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:50:50 -0400
Date: Wed, 04 Aug 2004 16:51:13 -0700 (PDT)
Message-Id: <20040804.165113.06226042.yoshfuji@linux-ipv6.org>
To: ak@muc.de
Cc: davem@redhat.com, jgarzik@pobox.com, axboe@suse.de,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: block layer sg, bsg
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040804232116.GA30152@muc.de>
References: <20040804191850.GA19224@havoc.gtf.org>
	<20040804122254.3d52c2d4.davem@redhat.com>
	<20040804232116.GA30152@muc.de>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040804232116.GA30152@muc.de> (at 5 Aug 2004 01:21:16 +0200,Thu, 5 Aug 2004 01:21:16 +0200), Andi Kleen <ak@muc.de> says:

> On Wed, Aug 04, 2004 at 12:22:54PM -0700, David S. Miller wrote:
> > On Wed, 4 Aug 2004 15:18:50 -0400
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> > > On Wed, Aug 04, 2004 at 07:28:04PM +0200, Andi Kleen wrote:
> > > > So please never pass any structures with read/write/netlink.
> > > 
> > > Sorry...  This is pretty much a given IMO.
> > 
> > Yes, netlink would be a nop if we gave in to Andi's reccomendation
> > :-)
> 
> Well, 32bit ipsec on x86-64/ia64 is a NOP because of that.

Hmm, I don't get the point.
What part (or which structore) is broken?

--yoshfuji
