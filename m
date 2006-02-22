Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWBVUxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWBVUxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWBVUxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:53:16 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54964 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751432AbWBVUxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:53:15 -0500
Date: Wed, 22 Feb 2006 13:53:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH/RFC] arch/x86_common: more formal reuse of i386+x86_64 source code
Message-ID: <20060222205314.GF2696@smtp.west.cox.net>
References: <20060208225336.23539710.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208225336.23539710.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 10:53:36PM -0800, Randy.Dunlap wrote:

> (not completed yet)
> (patch applies to 2.6.16-rc2)
> 
> Patch is 331 KB and is at
>   http://www.xenotime.net/linux/patches/x86-common1.patch
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Move lots of i386 & x86_64 common code into arch/x86_common/
> and modify Makefiles to use it from there.

I know I'm quite late here, but perhaps it should be arch/common?  I
remember thinking ages ago the i8259 stuff could be shared between ppc32
and i386 (it was ages ago).  And there's possibly other stuff like that.

-- 
Tom Rini
http://gate.crashing.org/~trini/
