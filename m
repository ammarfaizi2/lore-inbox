Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWBPWAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWBPWAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWBPWAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:00:16 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:45652 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932562AbWBPWAO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:00:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ex4KVkPz4IW/w5DPQ087SASqVrEAXqNBGEmd8G8IKxNyqZKfa6ht2aGpGHYhX4KZINk5/wtxD/uzYqucEcbpYMBLXpHxPsBOcb59HCrbpVIZw4DXYNvyLjD1iL8cKR7QG3VZrqzQUdTxRpDT97n6oDk3VAewFSWWz+NjkPCr7GM=
Message-ID: <21d7e9970602161400g129518eoaa195e74d37309b@mail.gmail.com>
Date: Fri, 17 Feb 2006 09:00:12 +1100
From: Dave Airlie <airlied@gmail.com>
To: Jesse Allen <the3dfxdude@gmail.com>
Subject: Re: 2.6.16-rc3: more regressions
Cc: =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
In-Reply-To: <530468570602150822q4977f091v5fabb39c42e652e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
	 <20060213183445.GA3588@stusta.de>
	 <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
	 <20060213190907.GD3588@stusta.de>
	 <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
	 <530468570602131527nbd17ddn262b92304adf4f86@mail.gmail.com>
	 <1139873757.17357.32.camel@localhost.localdomain>
	 <530468570602150822q4977f091v5fabb39c42e652e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Well, I did not know about the GART problem.  So this means that
> RV370s and XPRESS will be listed both separately in the driver in the
> future?  They certainly don't function as an RV350 and of course they
> aren't quite compatable then.

The RV350 and RV370 are more or less programatically the same, I'm not
sure there is any difference, the XPRESS chipsets although based on
RV370 have a whole different memory controller architecture by virtue
of being shared memory..

Dave.
