Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVAOVfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVAOVfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAOVfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:35:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262326AbVAOVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:35:19 -0500
Date: Sat, 15 Jan 2005 22:35:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arjan van de Ven <arjan@infradead.org>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050115213515.GQ4274@stusta.de>
References: <20050109194209.GA7588@infradead.org> <1105310650.11315.19.camel@lade.trondhjem.org> <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105471004.12005.46.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 02:16:44PM -0500, Trond Myklebust wrote:
> ty den 11.01.2005 Klokka 09:31 (+0100) skreiv Arjan van de Ven:
>...
> > If it is going to take a LOT longer though I still feel it's wrong to
> > bloat *everyones* kernel with this stuff.
> > 
> > (you may think "it's only 100 bytes", well, there are 700+ other such
> > functions, total that makes over at least 70Kb of unswappable, wasted
> > memory if not more.)
> 
> A list of these 700+ unused exported APIs would be very useful so that
> we can deprecate and/or get rid of them.
>...

Patches are already sent for each one that is found (the one by Arjan in 
this discusison is one of them).

My figures in [1] show, any kind of deprecation would mean _much_ extra 
work within the current 2.6 development model.

> Trond

cu
Adrian

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/2036.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

