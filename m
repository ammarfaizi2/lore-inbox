Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVADP2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVADP2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVADP2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:28:37 -0500
Received: from ns.suse.de ([195.135.220.2]:692 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261683AbVADP2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:28:24 -0500
Date: Tue, 4 Jan 2005 16:28:22 +0100
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH] x86_64: Add reboot=force
Message-ID: <20050104152822.GB19744@wotan.suse.de>
References: <200501040623.j046N1Sf011351@hera.kernel.org> <41DAB4EC.2070309@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DAB4EC.2070309@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 07:23:24AM -0800, Randy.Dunlap wrote:
> Linux Kernel Mailing List wrote:
> >ChangeSet 1.2136.3.75, 2005/01/03 20:44:39-08:00, ak@suse.de
> >
> >	[PATCH] x86_64: Add reboot=force
> >	
> >	Add reboot=force
> >	
> >	reboot=force doesn't wait for any other CPUs on reboot.  This is 
> >	useful when
> >	you really need a system to reboot on its own.
> 
> Why only for x86_64 ?

The x86-64 reboot code is quite different from i386 and I've only
seen the problems on x86-64. If you think it's useful on x86-64 too
feel free to port it over.

-Andi
