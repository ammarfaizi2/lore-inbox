Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQLRRxK>; Mon, 18 Dec 2000 12:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbQLRRxB>; Mon, 18 Dec 2000 12:53:01 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:21636 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129757AbQLRRwl>; Mon, 18 Dec 2000 12:52:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001218122853.A32153@oasis.fireblue.com> 
In-Reply-To: <20001218122853.A32153@oasis.fireblue.com> 
To: Abraham vd Merwe <abz@frogfoot.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: booting without VGA 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Dec 2000 17:19:51 +0000
Message-ID: <26759.977159991@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


abz@frogfoot.net said:
>  I'm currently wokring on a embedded system for a camera device. It
> runs linux and we use the M-Systems DiskOnChip driver (a seperate
> module available from their site) for storage and as a boot device.

> The problem is if we boot with a kernel WITH vga support enabled, it
> boots fine. If we disable vga support it doesn't seem to boot. What
> makes it even stranger is that if we boot with that same non-vga
> kernel using an IDE disk as boot device it also boots fine. 

You're using binary-only code. You shouldn't expect anyone on the l-k 
mailing list to give your problem a second thought.

Does it work if you use the GPL'd DiskOnChip driver which is in 
2.4.0-test12? You can also use it in 2.2 kernels.


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
