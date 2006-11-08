Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754601AbWKHRZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbWKHRZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbWKHRZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:25:34 -0500
Received: from [198.99.130.12] ([198.99.130.12]:16877 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1754601AbWKHRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:25:33 -0500
Date: Wed, 8 Nov 2006 13:19:36 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: slow UML on x86-64, soft lockups
Message-ID: <20061108181936.GE5698@ccure.user-mode-linux.org>
References: <4550FFFB.3000602@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4550FFFB.3000602@garzik.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 04:51:55PM -0500, Jeff Garzik wrote:
> Recent 2.6.18 / 2.6.19-rc kernels run at the expected speed, on 32-bit 
> x86, with a Fedora Core 5 or 6 UML userland.  However, on 64-bit x86-64 
> with a 64-bit UML userland, the kernel is achingly slow.  It works, 
> but...  Login takes several minutes (via ssh from host or xterm 
> console), and soft lockup traces continually print to the screen (see 
> output below).  Once logged into, programs work, but again, very slowly. 
>  Commands which complete in under a second normally often takes minutes.
> 
> Any ideas?  I guess there is a bug in the 64-bit UML timer code?

Has this changed?  If so, what's different?

What does UML look like on the host?  I.e. what processes are running,
and what does strace say that they're doing?

What does it look like inside UML?  Anything running wild in there?

				Jeff
-- 
Work email - jdike at linux dot intel dot com
