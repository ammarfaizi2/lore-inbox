Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSJ2XKv>; Tue, 29 Oct 2002 18:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJ2XKv>; Tue, 29 Oct 2002 18:10:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5134 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263313AbSJ2XKt>;
	Tue, 29 Oct 2002 18:10:49 -0500
Date: Tue, 29 Oct 2002 15:14:36 -0800
From: Greg KH <greg@kroah.com>
To: christophe varoqui <christophe.varoqui@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]partitions through device-mapper
Message-ID: <20021029231436.GB29560@kroah.com>
References: <Pine.GSO.4.21.0210290916360.9171-100000@weyl.math.psu.edu> <200210291941.10659.christophe.varoqui@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210291941.10659.christophe.varoqui@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 08:41:10PM +0200, christophe varoqui wrote:
> > a) devmapper is merged, but it sure as hell is not mandatory
> >
> let me argue that if I decide to hand my system FS to the device-mapper I 
> wouldn't want the current partition code to be mandatory either (devil's 
> advocate speaking)
> 
> > b) relying on the hotplug working right means living dangerously.  Right
> > now that code is brittle in the best case.
> >
> > c) all existing races in overlapping attach/detach (and $DEITY witness,
> > there's a plenty) immediately become much wider [OK, that's part of
> > (b), actully]
> >
> > IOW, right now the thing is nowhere near being ready for such use.
> 
> point taken.
> But, the question remains : do we want to get there in the end ?
> (question from the time-and-effort-worthy? departement)

>From what I understand about partitions, yes, I think we eventually do
want to get there.  

thanks,

greg k-h
