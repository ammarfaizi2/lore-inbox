Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424067AbWKIPhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424067AbWKIPhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424070AbWKIPhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:37:18 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:7779 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1424067AbWKIPhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:37:16 -0500
Message-ID: <45534B31.50008@cfl.rr.com>
Date: Thu, 09 Nov 2006 10:37:21 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Jano <jasieczek@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com> <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
In-Reply-To: <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 15:37:24.0563 (UTC) FILETIME=[F42A7A30:01C70414]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14802.003
X-TM-AS-Result: No--12.609300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ubuntu uses an initramfs, so unless he has rebuilt his kernel to get 
around that, he should still be using one.

OP, please check dmesg for any new errors after you attempt to mount 
something on hdb.  Also what is the output of a mount command with no 
options?

Jiri Slaby wrote:
> Aah, sorry for the question, you use 2.6.18.1 and there is no such 
> option yet.
> 
> Despite you have ide-generic built-in and other drivers have as a
> module and you don't use initrd. If I was you, I'll try to disable
> ide-generic and choose your ide chipset as built-in in
> ATA/ATAPI/MFM/RLL support under Device drivers.
> 
> regards,

