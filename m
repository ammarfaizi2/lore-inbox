Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbTABT4w>; Thu, 2 Jan 2003 14:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTABT4w>; Thu, 2 Jan 2003 14:56:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21255 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266555AbTABT4w>;
	Thu, 2 Jan 2003 14:56:52 -0500
Date: Thu, 2 Jan 2003 21:05:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: sam@ravnborg.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Documentation/modules.txt
Message-ID: <20030102200519.GA18655@mars.ravnborg.org>
Mail-Followup-To: Tomas Szepe <szepe@pinerecords.com>,
	sam@ravnborg.org, lkml <linux-kernel@vger.kernel.org>
References: <20030102192751.GA18197@mars.ravnborg.org> <20030102195409.GD17053@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102195409.GD17053@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 08:54:09PM +0100, Tomas Szepe wrote:
> >  Anyway, your first step is to compile the kernel, as explained in the
> >  file linux/README.  It generally goes like:
> >  
> > -	make config
> > -	make dep
> > +	make *config <= usually menuconfig or xconfig
> >  	make clean
> >  	make zImage or make zlilo
> 
> Won't 'dep' be necessary for modversions?
Based on the description on Rusty's page I do not think so.

And I would really like to see that step done automatically, since it
is not intuitive to do it, and the name "dep" is misleading at most.

	Sam
