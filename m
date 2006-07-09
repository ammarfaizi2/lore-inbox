Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWGIU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWGIU4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWGIU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:56:08 -0400
Received: from xenotime.net ([66.160.160.81]:36833 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161140AbWGIU4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:56:07 -0400
Date: Sun, 9 Jul 2006 13:58:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>, miles.lane@gmail.com
Cc: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Revert "ACPI: dock driver"
Message-Id: <20060709135852.9515371f.rdunlap@xenotime.net>
In-Reply-To: <20060709203310.GP13938@stusta.de>
References: <200607091559.k69Fx2h0029447@hera.kernel.org>
	<44B15BCB.5000306@vc.cvut.cz>
	<20060709203310.GP13938@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 22:33:10 +0200 Adrian Bunk wrote:

> On Sun, Jul 09, 2006 at 09:40:59PM +0200, Petr Vandrovec wrote:
> > Linux Kernel Mailing List wrote:
> > >commit 953969ddf5b049361ed1e8471cc43dc4134d2a6f
> > >tree e4b84effa78a7e34d516142ee8ad1441906e33de
> > >parent b862f3b099f3ea672c7438c0b282ce8201d39dfc
> > >author Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 
> > >-0700
> > >committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 
> > >-0700
> > >
> > >Revert "ACPI: dock driver"
> > >
> > >This reverts commit a5e1b94008f2a96abf4a0c0371a55a56b320c13e.
> > >
> > >Adrian Bunk points out that it has build errors, and apparently no
> > >maintenance. Throw it out.
> > 
> > Erm, what do I miss?  Code certainly builds, just before that checkin.
> >...
> 
> Not with all .config's:
> 
> http://lkml.org/lkml/2006/6/25/126
> http://lkml.org/lkml/2006/6/25/134

I set ACPI_DOCK=m and it builds OK.  I think that I used the
other config options from Miles's email.
and it still builds OK for me.

Miles, can I get your full failing .config file, please?

---
~Randy
