Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVAWOfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVAWOfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 09:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVAWOfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 09:35:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24803 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261307AbVAWOfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 09:35:05 -0500
Date: Sun, 23 Jan 2005 14:35:00 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, paulus@samba.org, tony.luck@intel.com, ak@suse.de,
       matthew@wil.cx, ralf@linux-mips.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Problems disabling SYSCTL
Message-ID: <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk>
References: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 04:01:02PM +1100, Anton Blanchard wrote:
> Create a cond_syscall for sys32_sysctl and make all architectures use
> it. Also fix the architectures that dont wrap their 32bit compat sysctl
> code.

Is there any reason to not move the sys32_sysctl code to kernel/sysctl.c?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
