Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUIXSNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUIXSNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIXSK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:10:27 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:41389 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S269029AbUIXSJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:09:19 -0400
Date: Fri, 24 Sep 2004 20:09:15 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Leonid Grossman <leonid.grossman@s2io.com>
Cc: "'David S. Miller'" <davem@davemloft.net>,
       "'Jeff Garzik'" <jgarzik@pobox.com>, alan@lxorguk.ukuu.org.uk,
       paul@clubi.ie, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-ID: <20040924180915.GB26922@xi.wantstofly.org>
References: <20040924130738.GB24093@xi.wantstofly.org> <200409241321.i8ODLf39012346@guinness.s2io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409241321.i8ODLf39012346@guinness.s2io.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 06:21:35AM -0700, Leonid Grossman wrote:

> > > And at 10GbE, embedded CPUs just don't cut it - it has to be custom 
> > > ASIC (granted, with some means to simplify debugging and reduce the 
> > > risk of hw bugs and TCP changes).
> > 
> > Intel's IXP2800 can do 10GbE.
> 
> Hi Lennert,

Hello,


> I was referring to the server side. 
> One can certanly build a 10GbE box based on IPX2800 (or some other parts),
> but at 17-25W it is not usable in NICs since the entire PCI card budget is
> less than that - nothing left for 10GbE PHY, memory, etc.

Ah, ok, that makes sense.  As someone else also noted, the IXP2800
only has a 64/66 PCI interface anyway, so it wouldn't really be
suitable for the task you were referring to.


cheers,
Lennert
