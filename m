Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVK3CbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVK3CbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVK3CbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:31:10 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3979 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750804AbVK3CbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:31:09 -0500
Date: Tue, 29 Nov 2005 18:31:02 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] setting irq affinity is broken in ia32 with MSI enabled
Message-ID: <20051129183101.A7794@unix-os.sc.intel.com>
References: <1133339835.8212.14.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1133339835.8212.14.camel@linux.site>; from shaohua.li@intel.com on Wed, Nov 30, 2005 at 12:37:15AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 12:37:15AM -0800, Shaohua Li wrote:
> Setting irq affinity stops working when MSI is enabled. With MSI,
> move_irq is empty, so we can't change irq affinity. It appears a typo in
> Ashok's original commit for this issue. X86_64 actually is using
> move_native_irq.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Yep...Think i missed the MSI/i386 case.


Looks good


Ashok Raj
