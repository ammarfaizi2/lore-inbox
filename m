Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWGCTnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWGCTnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGCTnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:43:15 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:6419 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751263AbWGCTnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:43:14 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Date: Mon, 3 Jul 2006 20:43:38 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org> <200607032007.11782.s0348365@sms.ed.ac.uk> <20060703123715.6e6d9c2c.akpm@osdl.org>
In-Reply-To: <20060703123715.6e6d9c2c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032043.38653.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 20:37, Andrew Morton wrote:
[snip]
> >   LD      arch/x86_64/boot/compressed/vmlinux
> > ld: warning: i386:x86-64 architecture of input file
> > `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
> >
> > I get this last one on mainline too.
>
> Perhaps a `make mrproper' is needed?

Nah, this was a fresh tree. Did it, tried again, still happening. It's 
possible the linker is broken in some way, but I only see this with the 
kernel.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
