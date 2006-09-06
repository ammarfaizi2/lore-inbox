Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWIFAKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWIFAKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWIFAKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:10:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61193 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965249AbWIFAKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:10:19 -0400
Date: Wed, 6 Sep 2006 02:10:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Miles Lane <miles.lane@gmail.com>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible	recursive	locking detected
Message-ID: <20060906001010.GN9173@stusta.de>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com> <20060905111306.80398394.akpm@osdl.org> <44FDCEAD.5070905@s5r6.in-berlin.de> <1157490479.28193.0.camel@laptopd505.fenrus.org> <44FDF9BC.1000403@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FDF9BC.1000403@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 12:27:08AM +0200, Stefan Richter wrote:
> Arjan van de Ven wrote:
> > On Tue, 2006-09-05 at 21:23 +0200, Stefan Richter wrote:
> >> This information confuses me. These places are not supposed to be the
> >> ones where the locks were actually acquired, are they?
> > 
> > they should be yes
> > (but inlined functions get the name of the function they are inlined
> > into)
> 
> Was there function inlining performed? E.g. on those functions that are
> called from only one place?

If a static function has only one caller it gets inlined.

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

