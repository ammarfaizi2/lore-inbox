Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUFOPmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUFOPmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUFOPmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:42:07 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31972 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S265697AbUFOPlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:41:37 -0400
Date: Tue, 15 Jun 2004 08:41:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615154136.GD11113@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614204029.GA15243@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:40:29PM +0200, Sam Ravnborg wrote:

> Hi Andrew. Here follows a number of kbuild patches.
> 
> The first replaces kbuild-specify-default-target-during-configuration.patch
> 
> They have seen ligiht testing here, but on the other hand the do not touch
> any critical part of kbuild.
> 
> Patches:
> 
> default kernel image:		Specify default target at config
> 				time rather then hardcode it.
> 				Only enabled for i386 for now.

While I'd guess this is better than the patch it's replacing, given that
most i386 kernels are 'bzImage', what's wrong with the current logic
that picks out what to do for the all target now?

-- 
Tom Rini
http://gate.crashing.org/~trini/
