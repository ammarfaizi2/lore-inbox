Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130195AbQKWUtz>; Thu, 23 Nov 2000 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130202AbQKWUtp>; Thu, 23 Nov 2000 15:49:45 -0500
Received: from napalm.go.cz ([212.24.148.98]:62724 "EHLO napalm.go.cz")
        by vger.kernel.org with ESMTP id <S130195AbQKWUt3>;
        Thu, 23 Nov 2000 15:49:29 -0500
Date: Thu, 23 Nov 2000 21:18:57 +0100
From: Jan Dvorak <johnydog@go.cz>
To: Phil Stracchino <alaric@babcom.com>
Cc: Linux-KERNEL <linux-kernel@vger.kernel.org>, support@vmware.com
Subject: Re: VMWare will not run on kernel 2.4.0-test11
Message-ID: <20001123211857.A18853@napalm.go.cz>
Mail-Followup-To: Phil Stracchino <alaric@babcom.com>,
        Linux-KERNEL <linux-kernel@vger.kernel.org>, support@vmware.com
In-Reply-To: <20001123120701.A1338@babylon5.babcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <20001123120701.A1338@babylon5.babcom.com>; from alaric@babcom.com on Thu, Nov 23, 2000 at 12:07:01PM -0800
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 12:07:01PM -0800, Phil Stracchino wrote:
> I just compiled and installed kernel 2.4.0-test11.  Upon rebooting,
> vmware-2.0.3-786 refused to run.  Running vmware-config.pl resulted in a
> the following message:
> 
> 	"Your processor does not have a Time Stamp Counter. VMware will
> 	 not run on this system."
> 
> Since (1) my hardware has not changed, (2) this VMware release ran
> perfectly on 2.4.0-test10, and (3) I changed nothing but the kernel in
> between 2.4.0-test10 and 2.4.0-test11, I feel quite confident in believing
> that I do indeed possess a Time Stamp Counter (whatever such a fabulous
> beast may be), but for some reason VMware is unable to detect its presence
> when running on kernel 2.4.0-test11.  Evidently there has been some change
> in the kernel which renders VMware unable to detect this mysterious - but
> apparently crucial - feature.
> 
> 
> I would appreciate any insights from either kernel folks or VMware folks
> as to where this problem may lie, with an eventual aim of patching either
> VMware or the kernel to allow VMware to run on this kernel.
>

It's probably due to /proc/cpuinfo change - 'flags' has changed to 'features'.

Jan Dvorak <johnydog@go.cz>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
