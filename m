Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUFGQem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUFGQem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUFGQem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:34:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:16843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264926AbUFGQek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:34:40 -0400
Date: Mon, 7 Jun 2004 09:33:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: akpm@osdl.org, tlnguyen@snoqualmie.dp.intel.com,
       linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH]2.6.7-rc1 Fix and Reenable MSI Support on x86_64
Message-Id: <20040607093324.734455a6.rddunlap@osdl.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502405570621@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502405570621@orsmsx404.amr.corp.intel.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 09:28:31 -0700 Nguyen, Tom L wrote:

| On Friday, June 04, 2004 Andrew Morton wrote: 
| 
| >>
| >> 
| >>  MSI support for x86_64 is currently disabled in the kernel 2.6.x.
| >>  Below is the patch, which provides a fix and reenable it.
| >
| >Could you please fix this up?
| >
| >arch/x86_64/kernel/i8259.c:118: warning: excess elements in array
| initializer
| >arch/x86_64/kernel/i8259.c:118: warning: (near initialization for
| `interrupt')
| >
| >.config is at http://www.zip.com.au/~akpm/linux/patches/stuff/config
| 
| Yes, I am looking into it right now. Please let me know which kernel you
| detected these warnings; so, I can repeat these warnings.

This is too simple, I guess, but I'd like to see .config contain
kernel version info....
updated by any "make *config", of course.

--
~Randy
