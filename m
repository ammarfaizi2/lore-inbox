Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbTIKQeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbTIKQeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:34:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43409 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261389AbTIKQeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:34:31 -0400
Date: Thu, 11 Sep 2003 17:34:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911163430.GC29532@mail.jlokier.co.uk>
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030911101704.GA24978@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911101704.GA24978@malvern.uk.w2k.superh.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Curnow wrote:
> >     SHMLBA not defined:		SH
> 
> What's the basis for deciding wheter SHMLBA is defined or not? There are
> definitions of SHMLBA in include/asm-sh/shmparam.h and
> include/asm-sh64/shmparam.h for the kernel.  The sh64 /usr/include/asm
> headers have effectively the same thing (not identical because the copy
> I'm looking at hasn't been synced with the latest kernel sources), and I
> assume the sh userland is OK too (haven't checked though).

That's a mistake of mine: it's defined in
include/asm-sh/sh*/shmparam.h and I didn't look there.

Userland: I'm reading the Glibc 2.3.1 source and I'm not sure if it
defines suitable SHMLBA for SH4.  There's no file in the Glibc tree,
but maybe the SH installation of Glibc includes the kernel header?

-- Jamie
