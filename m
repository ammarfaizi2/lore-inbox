Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWCNV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWCNV4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWCNV4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:56:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5771 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932521AbWCNV4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:56:46 -0500
Date: Tue, 14 Mar 2006 22:56:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] Require VM86 with VESA framebuffer
Message-ID: <20060314215634.GA2269@elf.ucw.cz>
References: <200603130917_MC3-1-BA83-2167@compuserve.com> <1142260227.3023.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142260227.3023.29.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 15:30:26, Arjan van de Ven wrote:
> On Mon, 2006-03-13 at 09:13 -0500, Chuck Ebbert wrote:
> > Force VM86 when VESA framebuffer is enabled and fix a typo
> > in the VM86 config entry. If VM86 is disabled there will
> > be problems when starting X using the VESA driver.
> 
> 
> this sounds wrong.
> 
> The kernel works fine; it's X that needs vm86.. (but it needs that
> anyway).... but that's no reason to make one kernel option require
> another....

How does X solve it on x86-64? x86-64 has no vm86. I agree it is X
that needs fixing.
								Pavel
-- 
199:    private byte [] sbuffer;
