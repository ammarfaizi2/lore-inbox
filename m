Return-Path: <linux-kernel-owner+w=401wt.eu-S1422702AbXAMQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbXAMQin (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbXAMQin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 11:38:43 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:10334 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422702AbXAMQim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 11:38:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FoyUao6KVHAcT/JJMC9os2kL00ZfSAc1aIekLYQksWqLc8d1oiFmF1JyRXi5BR59Ddxc7xe23JLzXruekKz6V7aHHv1fYZtkeIcrgyNYtMONmrlwvv0oVSPfaTjmv9lmoUYp0y22SVGy26AxzE1UUyBYKkl73mBFGO1GNwXbtrI=
Message-ID: <9e4733910701130838m120e43bcp121436d64a41e4a5@mail.gmail.com>
Date: Sat, 13 Jan 2007 11:38:41 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.20-rc5: known unfixed regressions
Cc: "Damien Wyart" <damien.wyart@free.fr>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Aaron Sethman" <androsyn@ratbox.org>, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <20070113155956.GP7469@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	 <20070113071125.GG7469@stusta.de> <87bql2ylfb.fsf@brouette.noos.fr>
	 <20070113155956.GP7469@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/07, Adrian Bunk <bunk@stusta.de> wrote:
> On Sat, Jan 13, 2007 at 04:51:36PM +0100, Damien Wyart wrote:
> > * Adrian Bunk <bunk@stusta.de> [070113 08:11]:
> > > This still leaves the old regressions we have not yet fixed...
> > > This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19.
> >
> > > Subject    : BUG: scheduling while atomic: hald-addon-stor/...
> > >              cdrom_{open,release,ioctl} in trace
> > > References : http://lkml.org/lkml/2006/12/26/105
> > >              http://lkml.org/lkml/2006/12/29/22
> > >              http://lkml.org/lkml/2006/12/31/133
> > > Submitter  : Jon Smirl <jonsmirl@gmail.com>
> > >              Damien Wyart <damien.wyart@free.fr>
> > >              Aaron Sethman <androsyn@ratbox.org>
> > > Status     : unknown
> >
> > I have not seen the problem since using rc3, so I guess it is ok now.
> > Maybe the commit 9414232fa0cc28e2f51b8c76d260f2748f7953fc has fixed the
> > problem, but I am not 100% sure.
>
> Thanks for this information.
>
> Jon, Aaron, can you confirm it's fixed in -rc5?

I can confirm that I haven't seen it for the last four or five days.
I've been tracking linus' tree. But, I was only hitting it about once
per day. So it is probably gone or it has become much harder to hit.

>
> > Damien Wyart
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
