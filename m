Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWBHAxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWBHAxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWBHAxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:53:08 -0500
Received: from fmr22.intel.com ([143.183.121.14]:34194 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030324AbWBHAxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:53:06 -0500
Message-Id: <200602080052.k180qxg16788@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adrian Bunk'" <bunk@stusta.de>, "Keith Owens" <kaos@sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Tue, 7 Feb 2006 16:52:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYsPPFDK3OSyOQ2RUW1nxBxQanZNgADErbQ
In-Reply-To: <20060207231713.GG3524@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote on Tuesday, February 07, 2006 3:17 PM
> IOW, you want the patch below?
> 

No, I really don't think so.


> --- linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig.old
> +++ linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig
> @@ -132,10 +134,11 @@
>  	  This choice is safe for all IA-64 systems, but may not perform
>  	  optimally on systems with, say, Itanium 2 or newer processors.
>  
>  config MCKINLEY
>  	bool "Itanium 2"
> +	depends on IA64_GENERIC=n
>  	help
>  	  Select this to configure for an Itanium 2 (McKinley) processor.
>  
>  endchoice
>  

This hunk does not make any logical sense.  Select generic system type
does not mean Itanium processor is the only choice I can have.  What's
wrong with having an option that works just fine right now?

- Ken

