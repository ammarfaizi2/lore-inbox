Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbTL3Dd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 22:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTL3Dd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 22:33:56 -0500
Received: from mail.ms.so-net.ne.jp ([202.238.82.30]:3992 "EHLO
	mx01.ms.so-net.ne.jp") by vger.kernel.org with ESMTP
	id S264365AbTL3Ddy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 22:33:54 -0500
Message-ID: <3FF0F1E3.7070309@turbolinux.co.jp>
Date: Tue, 30 Dec 2003 12:32:51 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.4) Gecko/20030925
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel   Configuration
 Tool
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com> <3FEF721D.7020405@rackable.com> <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au> <3FF071B1.6010202@rackable.com> <3FF07324.5050008@rackable.com>
In-Reply-To: <3FF07324.5050008@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just FYI.

This is my patch.
http://pkgcvs.turbolinux.co.jp/~go/patch-2.6/dpt_i2o.patch

Worked fine for me on quad xeon with 4G mem and 64bit PCI.
It include.
- Support 2.6 kernel and DMA-mapping
- ioctl fix for raid tools
- use schedule_timeout in long long loop
- not support 64bit CPU yet.

However, It may differ from the Adaptec policy (linux-scsi ML).

Samuel Flory wrote:
> Samuel Flory wrote:
> 
>>
>>   You might want to hold off on doing a lot of work for a bit.  I 
>> think there was a beta driver that was being passed around.
>>
> 
>   FYI I've found a beta release of the dpt-i2o driver that someone sent 
> me.  I'll see if I can figure out what the current status of it.
> 

