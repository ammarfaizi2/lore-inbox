Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWBVU4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWBVU4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWBVU4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:56:04 -0500
Received: from xenotime.net ([66.160.160.81]:15238 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751446AbWBVU4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:56:02 -0500
Date: Wed, 22 Feb 2006 12:55:56 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Tom Rini <trini@kernel.crashing.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH/RFC] arch/x86_common: more formal reuse of i386+x86_64
 source code
In-Reply-To: <20060222205314.GF2696@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0602221254500.8025@shark.he.net>
References: <20060208225336.23539710.rdunlap@xenotime.net>
 <20060222205314.GF2696@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Tom Rini wrote:

> On Wed, Feb 08, 2006 at 10:53:36PM -0800, Randy.Dunlap wrote:
>
> > (not completed yet)
> > (patch applies to 2.6.16-rc2)
> >
> > Patch is 331 KB and is at
> >   http://www.xenotime.net/linux/patches/x86-common1.patch
> >
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > Move lots of i386 & x86_64 common code into arch/x86_common/
> > and modify Makefiles to use it from there.
>
> I know I'm quite late here, but perhaps it should be arch/common?  I
> remember thinking ages ago the i8259 stuff could be shared between ppc32
> and i386 (it was ages ago).  And there's possibly other stuff like that.

Hi Tom,
Maybe, but ...
a few people like the "common" idea, but Andi has vetoed it,
so I've dropped it.

-- 
~Randy
