Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVBPTJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVBPTJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBPTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:09:22 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:5370 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261531AbVBPTJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:09:16 -0500
Message-ID: <42139A3D.2020202@tiscali.de>
Date: Wed, 16 Feb 2005 20:08:45 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Haven Skys <hskys@frontbridge.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Help: kernel option root=/dev/nfs failing 2.6.10
References: <004201c51452$131a6d60$2401a8c0@internal.bigfish.com>
In-Reply-To: <004201c51452$131a6d60$2401a8c0@internal.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven Skys wrote:

>I am attempting to create network bootable system with 2.6.10 and nfs and am
>having trouble.
>
>I am using grub and the boot goes without a hitch until the kernel attempts
>to use the commands I've sent.
>
><SNIP from grub.conf>
>bootp
>root (nd)
>kernel (nd)/redhat-2.6.10/kernel root=/dev/nfs ip=bootp
>nfsroot=10.0.120.1:/diskless/redhat-2.6.10/
>baseos
></SNIP>
>
>Network booting machine X does fine until. It attempts to open the root
>device.
>
><SNIP>
>VFS: Cannot open root device "nfs" or unknown-block(0,255) Please append a
>correct "root=" boot option Kernel panic - not syncing: VFS: Unable to mount
>root fs on unknown-block(0,255) </SNIP>
>
>It looks like the kernel isn't recognizing the virtual device /dev/nfs but
>I've enabled all the NFS options and everything is compiled into the kernel.
>
>Any ideas?
>
>
>Thanks
>Haven
> 
> 
>
>
>
>
>FrontBridge introduces Message Archive and Secure Email. Get leading Enterprise Message Security services from FrontBridge. www.frontbridge.com.
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
I did you follow the "tutorial" in Documentation/nfsroot.txt?

Matthias-Christian Ott
