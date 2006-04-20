Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWDTRPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWDTRPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDTROx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:14:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:12092 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751163AbWDTROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:14:50 -0400
X-IronPort-AV: i="4.04,141,1144047600"; 
   d="scan'208"; a="26451467:sNHT48037927"
Date: Thu, 20 Apr 2006 10:13:56 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Erich Focht <efocht@ess.nec.de>, linux-ia64@vger.kernel.org,
       eranian@hpl.hp.com, davidm@hpl.hp.com,
       Ben Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
       Jeff Dike <jdike@karaya.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 3/5] Remove redundant NULL checks before [kv]free - in  arch/
Message-ID: <20060420171356.GA19088@agluck-lia64.sc.intel.com>
References: <200604170328.42599.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604170328.42599.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:28:42AM +0200, Jesper Juhl wrote:
> Remove redundant NULL checks before [kv]free + small CodingStyle cleanup
> for arch/
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  arch/ia64/kernel/topology.c               |    7 --
>  arch/ia64/sn/kernel/xpc_partition.c       |    8 --

Applied ia64 pieces.  Thanks.

>  arch/powerpc/platforms/powermac/low_i2c.c |    3
>  arch/um/kernel/irq.c                      |   93 +++++++++++++++---------------
>  arch/um/os-Linux/irq.c                    |   47 +++++++--------

These bits left to fend for themselves in patchspace.

-Tony
