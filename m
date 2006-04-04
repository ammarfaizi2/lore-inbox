Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWDDUvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWDDUvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWDDUvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:51:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:60063 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750848AbWDDUvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:51:05 -0400
X-IronPort-AV: i="4.03,164,1141632000"; 
   d="scan'208"; a="19303552:sNHT27223826"
Date: Tue, 4 Apr 2006 13:50:55 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-ID: <20060404205055.GA5745@agluck-lia64.sc.intel.com>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 11:41:11PM -0800, akpm@osdl.org wrote:
> @@ -318,8 +318,9 @@
>  #define __NR_unshare		310
>  #define __NR_set_robust_list	311
>  #define __NR_get_robust_list	312
> +#define __NR_sys_sync_file_range 313

What's up with the __NR_sys_yada_yada?  Except for recent entries (kexec,
splice, and now sync_file_range) all of the other names in here have
dropped the "sys_".

Is it too late to fix __NR_sys_kexec_load (since it is out in the
wild now?)

-Tony
