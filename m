Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTCRUiQ>; Tue, 18 Mar 2003 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTCRUiQ>; Tue, 18 Mar 2003 15:38:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16364 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262580AbTCRUiP>; Tue, 18 Mar 2003 15:38:15 -0500
Date: Tue, 18 Mar 2003 21:49:03 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Andrew Morton <akpm@digeo.com>, davem@redhat.com,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] Re: 2.5.64-mm8: drivers/atm/idt77252.c doesn't compile
Message-ID: <20030318204903.GO18135@fs.tum.de>
References: <20030316154414.GB10253@fs.tum.de> <200303171543.h2HFhFGi012501@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303171543.h2HFhFGi012501@locutus.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 10:43:15AM -0500, chas williams wrote:
> In message <20030316154414.GB10253@fs.tum.de>,Adrian Bunk writes:
> > tx_inuse was removed from struct atm_vcc in include/linux/atmdev.h but 
> > drivers/atm/idt77252.c still needs it:
> 
> it doesnt need it -- it just needs to use the right member.  the following
> patch should fix the current errors.  i missed these bits during my
> earlier changes.
>...

Thanks, your patch fixes all tx_inuse compilation errors I observed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

