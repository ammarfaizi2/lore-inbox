Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVAHVdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVAHVdI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVAHVdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:33:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23753 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261500AbVAHVdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:33:05 -0500
Date: Sat, 8 Jan 2005 21:33:04 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Zou Nan hai <Nanhai.zou@intel.com>
Subject: Re: [PATCH] compat: sigtimedwait
Message-ID: <20050108213304.GH27371@parcelfarce.linux.theplanet.co.uk>
References: <200501050730.j057UAPM008164@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501050730.j057UAPM008164@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 05:36:02AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2117, 2005/01/04 21:36:02-08:00, nanhai.zou@intel.com
> 
> 	[PATCH] compat: sigtimedwait
> 	
> 	- Merge sys32_rt_sigtimedwait function in X86_64, IA64, PPC64, MIPS,
> 	  SPARC64, S390 32 bit layer into 1 compat_rt_sigtimedwait function.  It will
> 	  also fix a bug of copy wrong information to 32 bit userspace siginfo
> 	  structure on X86_64, IA64 and SPARC64 when calling sigtimedwait on 32 bit
> 	  layer.

Is there a reason you didn't do PA-RISC too?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
