Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUFPUI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUFPUI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUFPUI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:08:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15848 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S264717AbUFPUIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:08:25 -0400
Date: Wed, 16 Jun 2004 13:08:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040616200824.GF24479@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk> <20040615205557.GK2310@mars.ravnborg.org> <20040615220646.I7666@flint.arm.linux.org.uk> <20040616194919.GA4384@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616194919.GA4384@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 09:49:19PM +0200, Sam Ravnborg wrote:

> What about this much simpler approach?
> 
> One extra assignment for each architecture added to get access to the
> kernel image (at least the default one) for that architecture.

Will it also include the 'vmlinux' ?  And would I be right in assuming
that it will accept (a) globs and (b) can be defined inside of
arch/ppc/boot/foo/Makefile ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
