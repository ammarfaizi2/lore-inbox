Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbUKRG6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbUKRG6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbUKRG6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:58:22 -0500
Received: from ozlabs.org ([203.10.76.45]:55202 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262646AbUKRG6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:58:17 -0500
Date: Thu, 18 Nov 2004 17:56:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Six archs are missing atomic_inc_return()
Message-ID: <20041118065659.GA12007@krispykreme.ozlabs.ibm.com>
References: <200411180148_MC3-1-8EE2-A85D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411180148_MC3-1-8EE2-A85D@compuserve.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Six archs do not have the atomic_inc_return() macro as of 2.6.10-rc2:
> 
>   cris
>   h8300
>   m32r
>   ppc
>   ppc64
>   s390

Are you sure?

Anton

$ grep -l atomic_inc_return include/asm-*/atomic.h
include/asm-alpha/atomic.h
include/asm-arm26/atomic.h
include/asm-arm/atomic.h
include/asm-cris/atomic.h
include/asm-h8300/atomic.h
include/asm-i386/atomic.h
include/asm-ia64/atomic.h
include/asm-m32r/atomic.h
include/asm-m68k/atomic.h
include/asm-m68knommu/atomic.h
include/asm-mips/atomic.h
include/asm-parisc/atomic.h
include/asm-ppc64/atomic.h
include/asm-ppc/atomic.h
include/asm-s390/atomic.h
include/asm-sh64/atomic.h
include/asm-sh/atomic.h
include/asm-sparc64/atomic.h
include/asm-sparc/atomic.h
include/asm-v850/atomic.h
include/asm-x86_64/atomic.h
