Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWBRJEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWBRJEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 04:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBRJEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 04:04:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:772 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751078AbWBRJEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 04:04:11 -0500
Date: Sat, 18 Feb 2006 10:03:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060218090358.GA21587@mars.ravnborg.org>
References: <20060121180805.GA15761@suse.de> <20060121225728.GA13756@mars.ravnborg.org> <20060210194713.GA22599@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210194713.GA22599@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 08:47:13PM +0100, Olaf Hering wrote:
>  On Sat, Jan 21, Sam Ravnborg wrote:
> 
> 
> > +++ b/Makefile
> > @@ -259,38 +259,6 @@ endif
> >  
> >  export quiet Q KBUILD_VERBOSE
> >  
> > -######
> > -# cc support functions to be used (only) in arch/$(ARCH)/Makefile
> > -# See documentation in Documentation/kbuild/makefiles.txt
> 
> > +++ b/scripts/Kbuild.include
> > @@ -44,6 +44,43 @@ define filechk
> >  	fi
> >  endef
> >  
> > +######
> > +# cc support functions to be used (only) in arch/$(ARCH)/Makefile
> > +# See documentation in Documentation/kbuild/makefiles.txt
> 
> The comment needs updating.

Done - thanks.

	Sam
