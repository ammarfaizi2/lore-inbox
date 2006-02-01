Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWBAKo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWBAKo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWBAKo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:44:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2822 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161008AbWBAKoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:44:25 -0500
Date: Wed, 1 Feb 2006 11:44:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Armin Schindler <armin@melware.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
Message-ID: <20060201104419.GL3986@stusta.de>
References: <20060131213306.GG3986@stusta.de> <Pine.LNX.4.61.0602010943180.30915@phoenix.one.melware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602010943180.30915@phoenix.one.melware.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 09:43:48AM +0100, Armin Schindler wrote:
> On Tue, 31 Jan 2006, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> > - move the help text to the right option
> 
> where did you move it to? I just see the removal of the help text.

I moved it from ISDN_CAPI_CAPIFS to ISDN_CAPI_CAPIFS_BOOL (diff displays 
this a bit strange).

> Armin
>...
> >  config ISDN_CAPI_CAPIFS_BOOL
> >  	bool "CAPI2.0 filesystem support"
> >  	depends on ISDN_CAPI_MIDDLEWARE && ISDN_CAPI_CAPI20
> > -
> > -config ISDN_CAPI_CAPIFS
> > -	tristate
> > -	depends on ISDN_CAPI_CAPIFS_BOOL
> > -	default ISDN_CAPI_CAPI20
> >  	help
> >  	  This option provides a special file system, similar to /dev/pts with
> >  	  device nodes for the special ttys established by using the
> >  	  middleware extension above. If you want to use pppd with
> >  	  pppdcapiplugin to dial up to your ISP, say Y here.
> >  
> > +config ISDN_CAPI_CAPIFS
> > +	tristate
> > +	depends on ISDN_CAPI_CAPIFS_BOOL
> > +	default ISDN_CAPI_CAPI20
> > +
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

