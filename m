Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbUCYT0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUCYT0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:26:53 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:12607 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263538AbUCYT0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:26:49 -0500
Message-ID: <40633278.9060503@blueyonder.co.uk>
Date: Thu, 25 Mar 2004 19:26:48 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm3
References: <4062E015.2000608@blueyonder.co.uk>
In-Reply-To: <4062E015.2000608@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Mar 2004 19:26:49.0149 (UTC) FILETIME=[1E595ED0:01C4129F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't appear to have gotten through to the list. As it builds but 
doesn't boot fully on the Athlon XP2200+, I started with fresh sources 
and applied the patches, results the same.
Regards
Sid.

Sid Boyce wrote:

>  HOSTCC  usr/gen_init_cpio
>  CPIO    usr/initramfs_data.cpio
>  GZIP    usr/initramfs_data.cpio.gz
>  AS      usr/initramfs_data.o
>  LD      usr/built-in.o
>  CC      arch/x86_64/kernel/process.o
>  CC      arch/x86_64/kernel/semaphore.o
>  CC      arch/x86_64/kernel/signal.o
> arch/x86_64/kernel/signal.c: In function `do_signal':
> arch/x86_64/kernel/signal.c:426: warning: passing arg 2 of 
> `get_signal_to_deliver' from incompatible poi
> nter type
> arch/x86_64/kernel/signal.c:426: error: too few arguments to function 
> `get_signal_to_deliver'
> make[1]: *** [arch/x86_64/kernel/signal.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2
> Regards
> Sid.
>


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

