Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVBPUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVBPUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVBPUC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:02:26 -0500
Received: from mail-ash.bigfish.com ([206.16.192.253]:30060 "EHLO
	mail41-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S261718AbVBPUCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:02:00 -0500
X-BigFish: VP
From: "Haven Skys" <hskys@frontbridge.com>
To: "'Matthias-Christian Ott'" <matthias.christian@tiscali.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Help: kernel option root=/dev/nfs failing 2.6.10
Date: Wed, 16 Feb 2005 12:02:08 -0800
Message-ID: <005c01c51462$656c8b10$2401a8c0@internal.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <42139A3D.2020202@tiscali.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  Yes I have.
Here are a couple configuration options I have set:

CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_ROOT_NFS=y

Everything is textbook really.  I followed several different examples and
still nothing works.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Matthias-Christian
Ott
Sent: Wednesday, February 16, 2005 11:09 AM
To: Haven Skys
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help: kernel option root=/dev/nfs failing 2.6.10

Haven Skys wrote:

>I am attempting to create network bootable system with 2.6.10 and nfs and
am
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
>correct "root=" boot option Kernel panic - not syncing: VFS: Unable to
mount
>root fs on unknown-block(0,255) </SNIP>
>
>It looks like the kernel isn't recognizing the virtual device /dev/nfs but
>I've enabled all the NFS options and everything is compiled into the
kernel.
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
>FrontBridge introduces Message Archive and Secure Email. Get leading
Enterprise Message Security services from FrontBridge. www.frontbridge.com.
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



FrontBridge introduces Message Archive and Secure Email. Get leading Enterprise Message Security services from FrontBridge. www.frontbridge.com.



