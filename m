Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUCBWXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUCBWXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:23:24 -0500
Received: from gprs40-190.eurotel.cz ([160.218.40.190]:24409 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262055AbUCBWXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:23:20 -0500
Date: Tue, 2 Mar 2004 23:23:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Message-ID: <20040302222307.GB1225@elf.ucw.cz>
References: <20040227212301.GC1052@smtp.west.cox.net> <200403021709.26396.amitkale@emsyssoft.com> <20040302150544.GC16434@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302150544.GC16434@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It also makes core.patch dependent on 8250.patch
> > Any ideas on fixing that?
> 
> No, it's intentional.  eth.patch also depends on 8250.patch.

Perhaps that parts should be moved to core-lite? It should not be
neccessary to have serial support...

Or perhaps we want to decrease number of modules, and merge 8250 into
core-lite, having one less patch to care about?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
