Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWFIUiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWFIUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWFIUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:38:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16040 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965140AbWFIUiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:38:15 -0400
Message-ID: <4489DC2E.4030004@zytor.com>
Date: Fri, 09 Jun 2006 13:38:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nickolay <nickolay@protei.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: initramfs: who does cat init.sh >> init ?
References: <4489D93F.7090401@protei.ru> <e6cllv$dnb$1@terminus.zytor.com> <4489DB15.9010506@protei.ru>
In-Reply-To: <4489DB15.9010506@protei.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nickolay wrote:
>>
> I'm afraid, that you wrong.
> It is 2.6.17-rc4 git tree.
> 
> BE/2_6/initramfs is just CONFIG_INITRAMFS_SOURCE path.
> 

: neotrantor 11 ; fgrep -nr init.sh *
Documentation/filesystems/ramfs-rootfs-initramfs.txt:144:  file /init initramfs/init.sh 
755 0 0
Documentation/filesystems/ramfs-rootfs-initramfs.txt:151:two example "file" entries expect 
to find files named "init.sh" and "busybox" in

The only references to init.sh in the stock kernel tree are in a documentation file.

	-hpa
