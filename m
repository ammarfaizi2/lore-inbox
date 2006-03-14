Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWCNWNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWCNWNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCNWNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:13:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4995 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932525AbWCNWNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:13:53 -0500
Subject: Re: [patch] Require VM86 with VESA framebuffer
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060314215634.GA2269@elf.ucw.cz>
References: <200603130917_MC3-1-BA83-2167@compuserve.com>
	 <1142260227.3023.29.camel@laptopd505.fenrus.org>
	 <20060314215634.GA2269@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 23:13:49 +0100
Message-Id: <1142374429.3027.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 22:56 +0100, Pavel Machek wrote:
> On Po 13-03-06 15:30:26, Arjan van de Ven wrote:
> > On Mon, 2006-03-13 at 09:13 -0500, Chuck Ebbert wrote:
> > > Force VM86 when VESA framebuffer is enabled and fix a typo
> > > in the VM86 config entry. If VM86 is disabled there will
> > > be problems when starting X using the VESA driver.
> > 
> > 
> > this sounds wrong.
> > 
> > The kernel works fine; it's X that needs vm86.. (but it needs that
> > anyway).... but that's no reason to make one kernel option require
> > another....
> 
> How does X solve it on x86-64? x86-64 has no vm86. I agree it is X
> that needs fixing.


X has a complete enough x86 emulator for this stuff. Some builds of X
don't use it on x86,  but it works just fine; all other architectures
use it always anyway

