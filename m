Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVGRWfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVGRWfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVGRWfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 18:35:09 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:30385 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261314AbVGRWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 18:35:06 -0400
Message-ID: <42DC2F44.7000708@gentoo.org>
Date: Mon, 18 Jul 2005 23:37:56 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise TX4200 support?
References: <42DBFC9E.1040607@gentoo.org> <42DC0A99.2010304@solnet.cz>
In-Reply-To: <42DC0A99.2010304@solnet.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Povolný wrote:
> We are succesfully running patched sata_promise with 3 disks in a
> raid5/raid1 setup. (Patched against ubuntu linux-image 2.6.11-1-686
> package.)

Could you please either send in your patch, or tell me which board_ setting 
(2037x/20319/20619) the device ID table should include so I can write submit 
one myself.

> 'lspci -v' says:
> 
> 02:02.0 RAID bus controller: Promise Technology, Inc.: Unknown device
> 3519 (rev 02)
>         Subsystem: Promise Technology, Inc.: Unknown device 3519
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
>         I/O ports at dc00 [size=128]
>         I/O ports at d800 [size=256]
>         Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
>         Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at feae0000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 2

Thanks,
Daniel
