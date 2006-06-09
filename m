Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWFIUsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWFIUsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWFIUsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:48:20 -0400
Received: from ns.protei.ru ([195.239.28.26]:61708 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S965219AbWFIUsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:48:19 -0400
Message-ID: <4489DE84.309@protei.ru>
Date: Sat, 10 Jun 2006 00:48:04 +0400
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs: who does cat init.sh >> init ?
References: <4489D93F.7090401@protei.ru> <e6cllv$dnb$1@terminus.zytor.com> <4489DB15.9010506@protei.ru> <4489DC2E.4030004@zytor.com>
In-Reply-To: <4489DC2E.4030004@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Nickolay wrote:
>
>>>
>> I'm afraid, that you wrong.
>> It is 2.6.17-rc4 git tree.
>>
>> BE/2_6/initramfs is just CONFIG_INITRAMFS_SOURCE path.
>>
>
> : neotrantor 11 ; fgrep -nr init.sh *
> Documentation/filesystems/ramfs-rootfs-initramfs.txt:144:  file /init 
> initramfs/init.sh 755 0 0
> Documentation/filesystems/ramfs-rootfs-initramfs.txt:151:two example 
> "file" entries expect to find files named "init.sh" and "busybox" in
>
> The only references to init.sh in the stock kernel tree are in a 
> documentation file.
>
>     -hpa

yes, i can't grep init.sh in the kernel tree too, this is because i 
start asking...
But anyway, the problem is still...

-- 
Nickolay Vinogradov

