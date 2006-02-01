Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWBALBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWBALBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWBALBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:01:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:53444 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932445AbWBALBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:01:16 -0500
Date: Wed, 1 Feb 2006 12:01:06 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org, kkeil@suse.de
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
In-Reply-To: <20060201104419.GL3986@stusta.de>
Message-ID: <Pine.LNX.4.61.0602011159420.2155@phoenix.one.melware.de>
References: <20060131213306.GG3986@stusta.de> <Pine.LNX.4.61.0602010943180.30915@phoenix.one.melware.de>
 <20060201104419.GL3986@stusta.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, Adrian Bunk wrote:
> On Wed, Feb 01, 2006 at 09:43:48AM +0100, Armin Schindler wrote:
> > On Tue, 31 Jan 2006, Adrian Bunk wrote:
> > > This patch contains the following cleanups:
> > > - move the help text to the right option
> > 
> > where did you move it to? I just see the removal of the help text.
> 
> I moved it from ISDN_CAPI_CAPIFS to ISDN_CAPI_CAPIFS_BOOL (diff displays 
> this a bit strange).

Yes, sorry. I didn't look close enough. I should wait a bit after wake up... 

Armin
 
> > Armin
> >...
> > >  config ISDN_CAPI_CAPIFS_BOOL
> > >  	bool "CAPI2.0 filesystem support"
> > >  	depends on ISDN_CAPI_MIDDLEWARE && ISDN_CAPI_CAPI20
> > > -
> > > -config ISDN_CAPI_CAPIFS
> > > -	tristate
> > > -	depends on ISDN_CAPI_CAPIFS_BOOL
> > > -	default ISDN_CAPI_CAPI20
> > >  	help
> > >  	  This option provides a special file system, similar to /dev/pts with
> > >  	  device nodes for the special ttys established by using the
> > >  	  middleware extension above. If you want to use pppd with
> > >  	  pppdcapiplugin to dial up to your ISP, say Y here.
> > >  
> > > +config ISDN_CAPI_CAPIFS
> > > +	tristate
> > > +	depends on ISDN_CAPI_CAPIFS_BOOL
> > > +	default ISDN_CAPI_CAPI20
> > > +
> >...
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
> _______________________________________________
> isdn4linux mailing list
> isdn4linux@listserv.isdn4linux.de
> https://www.isdn4linux.de/mailman/listinfo/isdn4linux
> 
