Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUI3W6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUI3W6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbUI3W6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:58:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:54955 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269607AbUI3W60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:58:26 -0400
Date: Thu, 30 Sep 2004 15:57:04 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] inotify: make user visible types portable
Message-Id: <20040930155704.16d71cec.pj@sgi.com>
In-Reply-To: <1096583108.4203.86.camel@betsy.boston.ximian.com>
References: <1096410792.4365.3.camel@vertex>
	<1096583108.4203.86.camel@betsy.boston.ximian.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:
> "__u32" just does not have the same ring to it as "unsigned long".

Why not "u32"?

$ grep '^typedef.* u32;$' include/asm-*/*.h
include/asm-alpha/types.h:typedef unsigned int u32;
include/asm-arm/types.h:typedef unsigned int u32;
include/asm-arm26/types.h:typedef unsigned int u32;
include/asm-cris/types.h:typedef unsigned int u32;
include/asm-h8300/types.h:typedef unsigned int u32;
include/asm-i386/types.h:typedef unsigned int u32;
include/asm-ia64/types.h:typedef __u32 u32;
include/asm-m32r/types.h:typedef unsigned int u32;
include/asm-m68k/types.h:typedef unsigned int u32;
include/asm-mips/types.h:typedef unsigned int u32;
include/asm-parisc/types.h:typedef unsigned int u32;
include/asm-ppc/types.h:typedef unsigned int u32;
include/asm-ppc64/types.h:typedef unsigned int u32;
include/asm-s390/types.h:typedef unsigned int u32;
include/asm-sh/types.h:typedef unsigned int u32;
include/asm-sh64/types.h:typedef unsigned int u32;
include/asm-sparc/types.h:typedef unsigned int u32;
include/asm-sparc64/types.h:typedef unsigned int u32;
include/asm-v850/types.h:typedef unsigned int u32;
include/asm-x86_64/types.h:typedef unsigned int u32;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
