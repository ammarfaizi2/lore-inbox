Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWJXT2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWJXT2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbWJXT2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:28:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6926 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752033AbWJXT2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:28:47 -0400
Date: Tue, 24 Oct 2006 21:28:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061024192845.GC27968@stusta.de>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610242124.49911.arnd@arndb.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 09:24:49PM +0200, Arnd Bergmann wrote:
> On Monday 16 October 2006 15:33, Christoph Hellwig wrote:
> > On Sun, Oct 15, 2006 at 04:31:29PM +0159, Jiri Slaby wrote:
> > > What:   remove EXPORT_SYMBOL(kernel_thread)
> > > When:   August 2006
> > > Who:    Christoph Hellwig <hch@lst.de>
> >
> > There are a lot of modular users left.  It'll go away as soon as these
> > users have disappeared.
> 
> It seems that most of the users that are left are for pretty obscure
> functionality, so I wouldn't expect that to happen so soon. Maybe we
> should mark it as __deprecated in the declaration?

__deprecated_for_modules (__deprecated would imply it would be 
completely removed).

> 	Arnd <><

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

