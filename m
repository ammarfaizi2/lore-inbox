Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWFIUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWFIUdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWFIUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:33:43 -0400
Received: from ns.protei.ru ([195.239.28.26]:29971 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S932264AbWFIUdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:33:42 -0400
Message-ID: <4489DB15.9010506@protei.ru>
Date: Sat, 10 Jun 2006 00:33:25 +0400
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs: who does cat init.sh >> init ?
References: <4489D93F.7090401@protei.ru> <e6cllv$dnb$1@terminus.zytor.com>
In-Reply-To: <e6cllv$dnb$1@terminus.zytor.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>Followup to:  <4489D93F.7090401@protei.ru>
>By author:    Nickolay <nickolay@protei.ru>
>In newsgroup: linux.dev.kernel
>  
>
>>Guys, in recent kernels, when building kernel with initramfs with V=1, 
>>i  see interesting one:
>>
>>cat /usr/kernel/BE/2_6/initramfs/init.sh >/usr/kernel/BE/2_6/initramfs/init
>>
>>But i can't find, who really do that. Can anyone point me?
>>I need to fix that, because it's impossible for me to have two copy of init.
>>
>>    
>>
>
>Nothing that's part of the standard kernel, that's for sure.
>
>Looks like you have something patched, possibly by a vendor.  The
>BE/2_6 bit definitely looks that way.
>
>	-hpa
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
I'm afraid, that you wrong.
It is 2.6.17-rc4 git tree.

BE/2_6/initramfs is just CONFIG_INITRAMFS_SOURCE path.

-- 
Nickolay Vinogradov

