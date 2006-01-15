Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWAOO04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWAOO04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 09:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWAOO04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 09:26:56 -0500
Received: from mx01.qsc.de ([213.148.129.14]:55498 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S1750916AbWAOO0z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 09:26:55 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Date: Sun, 15 Jan 2006 15:26:34 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
References: <200601151051.14827.rene@exactcode.de> <200601151312.42391.rene@exactcode.de> <20060115123133.GB15881@mars.ravnborg.org>
In-Reply-To: <20060115123133.GB15881@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601151526.34236.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 15 January 2006 13:31, Sam Ravnborg wrote:
	> > I'm curious, aside rsbac, what in the .config is altering the > >
	KERNELRELEASE? > > CONFIG_LOCALVERSION > CONFIG_LOCALVERSION_AUTO Ah, ok
	- I feared something less obviously more complex. Do we need this
	options at all? People can still just edit the EXTRAVERSION line in the
	Makefile - at least I always did so ... [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 15 January 2006 13:31, Sam Ravnborg wrote:
> > I'm curious, aside rsbac, what in the .config is altering the
> > KERNELRELEASE?
>
> CONFIG_LOCALVERSION
> CONFIG_LOCALVERSION_AUTO

Ah, ok - I feared something less obviously more complex. Do we need this 
options at all? People can still just edit the EXTRAVERSION line in the 
Makefile - at least I always did so ...

Also you have not answered if you expect to patch away the version output in 
the *config frontends ...

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
