Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTIXS5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 14:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTIXS5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 14:57:23 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:25493 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261605AbTIXS5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 14:57:20 -0400
Date: Wed, 24 Sep 2003 20:56:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       andrea@kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924185614.GA19828@wohnheim.fh-wedel.de>
References: <20030924031602.GA7887@work.bitmover.com> <Pine.LNX.4.44.0309232327490.15940-100000@chimarrao.boston.redhat.com> <20030924034552.GB7887@work.bitmover.com> <1064408978.13459.34.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1064408978.13459.34.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 September 2003 14:09:38 +0100, Alan Cox wrote:
> 
> It isnt just sizes. As the size has risen rapidly the disk data rates
> have increased pretty well (factor of about 100 over an MFM disk 386)
> but the seek time has shifted by a factor of 10. This has a huge impact
> on the whole basic theory of things like paging in applications versus
> doing a streaming preload of the code/data.
> 
> It also has a big impact on how swap is managed - it is pretty much as
> cheap now to swap out 2Mb as 4K

How do you get to 2MB?  My rule of thumb number is still 100kB.

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
