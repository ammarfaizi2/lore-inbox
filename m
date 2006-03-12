Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWCLNtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWCLNtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWCLNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:49:53 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:57513 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751462AbWCLNtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:49:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.16-rc6-mm1
Date: Sun, 12 Mar 2006 14:49:09 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060312031036.3a382581.akpm@osdl.org> <200603121416.26583.rjw@sisk.pl> <20060312133514.GA9922@mars.ravnborg.org>
In-Reply-To: <20060312133514.GA9922@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121449.10223.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 14:35, Sam Ravnborg wrote:
> On Sun, Mar 12, 2006 at 02:16:26PM +0100, Rafael J. Wysocki wrote:
> > On Sunday 12 March 2006 12:10, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> > 
> > Doesn't compile for me:
> > 
> > rafael@albercik:~/src/mm/linux-2.6.16-rc6-mm1> make
> >   CHK     include/linux/version.h
> >   SPLIT   include/linux/autoconf.h -> include/config/*
> >   HOSTCC  scripts/genksyms/genksyms.o
> > scripts/genksyms/genksyms.c:35:30: error: ../mod/elfconfig.h: No such file or directory
> > scripts/genksyms/genksyms.c: In function ???export_symbol???:
> > scripts/genksyms/genksyms.c:461: error: ???MODULE_SYMBOL_PREFIX??? undeclared (first use in this function)
> > scripts/genksyms/genksyms.c:461: error: (Each undeclared identifier is reported only once
> > scripts/genksyms/genksyms.c:461: error: for each function it appears in.)
> > make[2]: *** [scripts/genksyms/genksyms.o] Error 1
> > make[1]: *** [scripts/genksyms] Error 2
> > make: *** [scripts] Error 2
> My bad.
>  
> > #
> > # Loadable module support
> > #
> > CONFIG_MODULES=y
> > CONFIG_MODULE_UNLOAD=y
> > CONFIG_MODULE_FORCE_UNLOAD=y
> > CONFIG_MODVERSIONS=y
> Use CONFIG_MODVERSIONS=n for now as workaround.

OK

Thanks,
Rafael
