Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTIOHCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIOHCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:02:53 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:26019 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262459AbTIOHCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:02:51 -0400
Date: Mon, 15 Sep 2003 09:02:06 +0200
From: Michael Neuffer <neuffer@neuffer.info>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030915070206.GH1455@neuffer.info>
References: <20030913222443.GN27368@fs.tum.de> <20030913222659.GO27368@fs.tum.de> <20030915064623.GA6772@neuffer.info> <20030915065211.GB126@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030915065211.GB126@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@fs.tum.de):
> On Mon, Sep 15, 2003 at 08:46:23AM +0200, Michael Neuffer wrote:
> > Quoting Adrian Bunk (bunk@fs.tum.de):
> > > [...]
> > > - help text changes/updates
> > > [...]  
> > > -config M686
> > > +config CPU_686
> > >  	bool "Pentium-Pro"
> > >  	help
> > > -	  Select this for Intel Pentium Pro chips.  This enables the use of
> > > -	  Pentium Pro extended instructions, and disables the init-time guard
> > > -	  against the f00f bug found in earlier Pentiums.
> > > +	  Select this for Intel Pentium Pro chips.
> > > [...one example left]  
> > 
> > Is there a valid reason why you removed most of the
> > descriptions ? I think a bit of a background on the
> > CPU selections is helpful and interesting, especially 
> > for newcommers. You've cut it down so far, that you 
> > could also put there "Read Variable Name" or 
> > "No help available"  instead.
> 
> With the CPU selection scheme I propose this is no longer true. 
> Especially the f00f workaround is no longer disabled when configuring 
> for a Pentium Pro or above, it's only enabled when you select the older 
> Pentium - but this setting is now independend of the Pentium Pro 
> setting.

Hi Adrian

OK, bad example. What about the rest ?


Cheers
  Mike
