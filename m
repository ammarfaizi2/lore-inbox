Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUBOCih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 21:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUBOCih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 21:38:37 -0500
Received: from [218.5.74.208] ([218.5.74.208]:20414 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S263711AbUBOCif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 21:38:35 -0500
Message-ID: <402EDBA8.4070102@lovecn.org>
Date: Sun, 15 Feb 2004 10:38:32 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <402A887D.7030408@t-online.de>
In-Reply-To: <402A887D.7030408@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:

> Hi folks,
>
> 'cat /proc/modules' returns most (all?) of the module names with
> "_", e.g.
>
>     :
>     ipt_conntrack
>     ip_conntrack
>     iptable_filter
>     ip_tables
>     uhci_hcd
>     ohci_hcd
>     ehci_hcd
>     :
>
> Very consistent. But the filenames of some kernel modules are
> still written with "-", e.g.
>
>     /lib/modules/2.6.2/kernel/drivers/usb/host/ehci-hcd.ko
>     /lib/modules/2.6.2/kernel/drivers/usb/host/ohci-hcd.ko
>     /lib/modules/2.6.2/kernel/drivers/usb/host/uhci-hcd.ko
>
> What would be the correct way to get the filename of a
> loaded module? The basename would be sufficient.
>
>
> Regards
>
> Harri
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
The symbole names used in source code, like function names tend to use 
"_", while the file names use "-" IMHO.


Coywolf Qi Hunt

