Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266302AbUGOUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUGOUtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUGOUtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:49:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:224 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266302AbUGOUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:49:43 -0400
Date: Thu, 15 Jul 2004 22:49:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.6 patch] e1000_main.c: fix inline compile errors
Message-ID: <20040715204935.GI25633@fs.tum.de>
References: <20040714210121.GN7308@fs.tum.de> <200407151213.59568.vda@port.imtp.ilyichevsk.odessa.ua> <20040715194623.GD25633@fs.tum.de> <200407152326.40331.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407152326.40331.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 11:26:40PM +0300, Denis Vlasenko wrote:
> On Thursday 15 July 2004 22:46, Adrian Bunk wrote:
> > On Thu, Jul 15, 2004 at 12:13:59PM +0300, Denis Vlasenko wrote:
> > >...
> > > As you go thru them, consider removing inline keyword for
> > > such large functions.
> > >...
> >
> > I did propose this as an alternative approach in the text that
> > accopagnied the patch.
> >
> > My main reason for not directly proposing to remove the inlines was the
> > fact that all inline functions were either very small or called only
> > once.
> 
> I think that large inlines with one callee is overoptimization
> and should not be done.

Unless I'm mistaken, it's simply equivalent to putting the code of the 
function at the place where the only call of the function currently is?

Or is there an additional problem I miss?

> vda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

