Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVGMWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVGMWJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVGMSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:43:48 -0400
Received: from mta01.mail.t-online.hu ([195.228.240.50]:54227 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261539AbVGMSlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:41:46 -0400
Subject: Re: [PATCH 0/19] Kconfig I18N completion
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <20050713201147.GA23746@mars.ravnborg.org>
References: <1121273456.2975.3.camel@spirit>
	 <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
	 <1121277818.2975.68.camel@spirit>
	 <20050713201147.GA23746@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 20:41:44 +0200
Message-Id: <1121280104.2975.84.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Sam Ravnborg wrote:
> On Wed, Jul 13, 2005 at 08:03:38PM +0200, Egry G?bor wrote:
> > On Wed, 13 Jul 2005, Linus Torvalds wrote:
> > > On Wed, 13 Jul 2005, Egry G??bor wrote:
> > > > 
> > > > The following patches complete the "Kconfig I18N support" patch by
> > > > Arnaldo. 
> > > 
> > > No, I really don't want this.
> > > 
> > > I was told that the whole point of Arnaldo's work was that the actual po 
> > > files etc wouldn't need to be with the kernel, and could be a separate 
> > > package, maintained separately. Now I'm seeing patches that seem to make 
> > > that a lie.
> > 
> > Hmm, what .po files do you say about?
> Patch 19/19 contains a .po file.
> 
> 	Sam

Yes, the patch 19/19 contains the translation of configuration
interfaces ([x|g|menu]config) and it is only 23 kb. The full version of
unfinished hu.po is 2 MB and the fully translated italian it.po is 3,2
MB. I see Linus doesn't want the huge language files in kernel source.
But what is Linus opinion about this little .po file?

Gabor

