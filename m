Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVAZCUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVAZCUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVAZCUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 21:20:16 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:60642 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262050AbVAZCUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 21:20:11 -0500
Date: Wed, 26 Jan 2005 03:20:04 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050126022004.GA25350@wohnheim.fh-wedel.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda> <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda> <58cb370e050125073464befe4@mail.gmail.com> <1106669087.5257.100.camel@uganda> <20050125182110.GA23317@wohnheim.fh-wedel.de> <20050126001734.34297f5b@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050126001734.34297f5b@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 January 2005 00:17:34 +0300, Evgeniy Polyakov wrote:
> 
> That will catch only simple cases - for the whole picture you need
> to run graph generator from all allowed code pathes, but that
> will require knowledge of the tested system, so it will not and 
> actually can not be absolutely generic.

Oh, we both agree on that, although we used different words.  The
design actually is as simple as outlined, the messy part is getting
the complete call graph of the kernel in the first place.

I have a good deal of that part done, but the code is ugly and there
are legal issues... but it shows that it's quite possible to do.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
