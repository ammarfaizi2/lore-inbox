Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUAIQTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUAIQTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:19:20 -0500
Received: from tench.street-vision.com ([212.18.235.100]:19334 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262128AbUAIQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:19:19 -0500
Subject: Re: kernel 2.4.24 - weird priorities for RAID processes
From: Justin Cormack <justin@street-vision.com>
To: Konstantin Kudin <konstantin_kudin@yahoo.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040109161047.46078.qmail@web21204.mail.yahoo.com>
References: <20040109161047.46078.qmail@web21204.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 09 Jan 2004 16:19:19 +0000
Message-Id: <1073665160.1766.23.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update your procps utils.


On Fri, 2004-01-09 at 16:10, Konstantin Kudin wrote:
>  The 2.4.24 kernel reports weird priorities for
> certain processes.
> 
> 
> kiev:~>cat /proc/version
> Linux version 2.4.24 (root@kiev.somewhere.EDU) (gcc
> version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP
> Thu
> Jan 8 16:47:09 EST 2004
> 
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM
>   TIME CPU COMMAND
>     6 root       9   0     0    0     0 SW    0.0  0.0
>   0:00   0 bdflush
>     7 root       9   0     0    0     0 SW    0.0  0.0
>   0:00   0 kupdated
>     8 root     18446744073709551615 -20     0    0    
> 0 SW<   0.0  0.0   0:00   1 mdrecoveryd
>    16 root     18446744073709551615 -20     0    0    
> 0 SW<   0.0  0.0   0:00   0 raid1d
> 
> 
> 
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
> http://hotjobs.sweepstakes.yahoo.com/signingbonus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


