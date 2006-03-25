Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWCYQCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWCYQCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCYQCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:02:13 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:50847 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751176AbWCYQCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:02:13 -0500
Date: Sat, 25 Mar 2006 11:03:01 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>,
       Mariusz Mazur <mmazur@kernel.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       llh-discuss@lists.pld-linux.org
Subject: Re: State of userland headers
Message-ID: <20060325160301.GA3226@ccure.user-mode-linux.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060325013615.GD8117@ccure.user-mode-linux.org> <7321E6DA-90FE-4CFC-9AA3-DDC53BB7BC4A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7321E6DA-90FE-4CFC-9AA3-DDC53BB7BC4A@mac.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 01:33:55AM -0500, Kyle Moffett wrote:
> So perhaps could we define an informal subset of the kernel code that  
> works in both userspace and kernel-space and put it in include/libk?   
> Stuff like linked lists, spinlocks (depends on arch, may not be  
> supported), etc could be in linux/libk and linux/include/libk or  
> similar, and then from there included into linux/include/linux/ 
> list.h, etc, as well as into the UML files that need it.  Since the  
> provider and user would both be the Linux kernel, I see no issues  
> with trying to provide a stable interface of any kind, especially if  
> we document it as "PRIVATE - FOR KERNEL USE ONLY!!!" with big warning  
> signs. As a nice bonus, this would make it possible to implement some  
> user-space unit tests of various pieces.

This would be perfect.

			Jeff
