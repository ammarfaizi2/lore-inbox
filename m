Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTDMDYu (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbTDMDYu (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:24:50 -0400
Received: from fmr03.intel.com ([143.183.121.5]:39645 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263133AbTDMDYt convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:24:49 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAB60@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Timothy Miller'" <tmiller10@cfl.rr.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Page compression in lieu of swap?
Date: Sat, 12 Apr 2003 20:36:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Timothy Miller [mailto:tmiller10@cfl.rr.com]
> 
> 
> Given the hideous amount of time required to access a disk, especially
when
> something else wants to access it, could there be a benefit to "swapping"
> pages by compressing them to somewhere else in memory?  If we could
achieve,
> even say, 30% compression on pages, on average, then we could free up RAM

I tried this sometime ago (2.2.x timeframe) for canning mozilla into an
small amount of memory and it was kind of doable - not too complicated,
in fact - the only thing is it would reduce the machine to a crawl some
times (I guess I did not know how to throttle the swap) - I even got it
working with bzip2 -9 [this was a pure exercise].

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
