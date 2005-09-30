Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbVI3WYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVI3WYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVI3WYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:24:21 -0400
Received: from fmr23.intel.com ([143.183.121.15]:43185 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030476AbVI3WYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:24:19 -0400
Date: Fri, 30 Sep 2005 15:23:59 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
Message-ID: <20050930152358.D28092@unix-os.sc.intel.com>
References: <20050929190419.C15943@unix-os.sc.intel.com> <433D391A.70607@vc.cvut.cz> <20050930112310.A28092@unix-os.sc.intel.com> <200510010002.16382.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510010002.16382.ak@suse.de>; from ak@suse.de on Sat, Oct 01, 2005 at 12:02:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 12:02:16AM +0200, Andi Kleen wrote:
> I applied an earlier mix of your original one and Petr's suggestions. Hope 
> it's ok. 

Andi I prefer to follow the SDM guidelines. Who knows if future families
comeup with a different rule or use/initialize these extended model/family
bits differently. I am just being paranoid.

> +		if (c->x86 >= 0xf) 

And also you have a typo. It should be 0x6.

Anyhow, I prefer my second patch.

thanks,
suresh
