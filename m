Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUGISrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUGISrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUGISq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:46:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33023 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265233AbUGISq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:46:58 -0400
Date: Fri, 9 Jul 2004 20:46:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>,
       Bastian Blank <bastian@waldi.eu.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-ID: <20040709184646.GS28324@fs.tum.de>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org> <20040709140947.GA32405@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709140947.GA32405@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 03:09:47PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 09, 2004 at 04:06:30PM +0200, Bastian Blank wrote:
> > Hi Andrew
> > 
> > The attached patch marks IPv6 support for QETH broken, it is known to
> > need an extra patch to compile which was submitted one year ago but
> > never accepted.
> 
> If it doesn't even compile BROKEN isn't enough.  In that case cometely
> uncomment the option in Kconfig.

Why shouldn't it be enough?

BROKEN and BROKEN_ON_SMP are the way non-compiling drivers as well as 
in any other way broken drivers are currently handled in 2.6 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

