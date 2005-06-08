Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVFHX0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVFHX0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFHX0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:26:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:57216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261329AbVFHX0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:26:41 -0400
Date: Wed, 8 Jun 2005 16:28:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org,
       jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
In-Reply-To: <17063.31568.618739.165823@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0506081624390.2286@ppc970.osdl.org>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
 <17063.31568.618739.165823@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Jun 2005, Paul Mackerras wrote:
> 
> Interestingly, PER_LINUX32 has nothing whatsoever to do with whether a
> process is running in 32-bit or 64-bit mode.  In fact, the *only*
> thing that PER_LINUX32 affects is the machine name reported by uname.
> So you can have a 32-bit process without PER_LINUX32, and a 64-bit
> process with PER_LINUX32.

Ok, I stand corrected. I was assuming it got set automatically for 32-bit 
processes, without checking.

		Linus
