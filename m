Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbUJ3XSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUJ3XSC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUJ3XQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:16:35 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:7565 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261404AbUJ3WtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:49:09 -0400
Date: Sun, 31 Oct 2004 02:49:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jim Nelson <james4765@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More patches to arch/sparc/Kconfig [2 of 5]
Message-ID: <20041031004953.GK9592@mars.ravnborg.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jim Nelson <james4765@verizon.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41738FD4.5020008@verizon.net> <20041018102738.GF5607@holomorphy.com> <41744695.4020406@verizon.net> <20041018224429.GH5607@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018224429.GH5607@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 03:44:29PM -0700, William Lee Irwin III wrote:
> On Mon, Oct 18, 2004 at 06:41:25PM -0400, Jim Nelson wrote:
> > You may be right about openpromfs.  How's this instead:
> > diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig
> > --- arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
> > +++ arch/sparc/Kconfig	2004-10-18 18:38:05.125374024 -0400
> > @@ -248,7 +248,10 @@
> >  	  -t openpromfs none /proc/openprom".
> >  
> >  	  To compile the /proc/openprom support as a module, choose M here: the
> > -	  module will be called openpromfs.  If unsure, choose M.
> > +	  module will be called openpromfs.
> > +
> > +	  Only choose N if you know in advance that you will not need to modify
> > +	  OpenPROM settings on the running system.
> >  
> >  source "fs/Kconfig.binfmt"
> 
> This looks fine to me.

I took these five aptches in via my tree.
Next time I prefer _all_ patches to be inlined as plain text and
generated so they uses patch -p1 when being applied.

	Sam
