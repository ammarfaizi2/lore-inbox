Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTIYLbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbTIYLbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:31:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33998 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261831AbTIYLa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:30:59 -0400
Date: Thu, 25 Sep 2003 13:30:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix non-modular ftape compile
Message-ID: <20030925113054.GP15696@fs.tum.de>
References: <20030925102309.GI15696@fs.tum.de> <20030925113816.A9693@infradead.org> <20030925110325.GK15696@fs.tum.de> <20030925121913.A10483@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925121913.A10483@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 12:19:13PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 25, 2003 at 01:03:25PM +0200, Adrian Bunk wrote:
> > It increases the kernel size since in 2.6 __exit functions are discarded 
> > at runtime and not at link time.
> 
> Oh.  That sounds silly.  Do you remember who changed it and why?

Andi Kleen changed it, it was needed for .altinstructions .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

