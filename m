Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278267AbRJSBTV>; Thu, 18 Oct 2001 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278266AbRJSBTN>; Thu, 18 Oct 2001 21:19:13 -0400
Received: from mail.wave.co.nz ([203.96.216.11]:29733 "EHLO mail.wave.co.nz")
	by vger.kernel.org with ESMTP id <S278263AbRJSBS5>;
	Thu, 18 Oct 2001 21:18:57 -0400
Date: Fri, 19 Oct 2001 14:19:27 +1300
From: Mark van Walraven <markv@wave.co.nz>
To: linux-kernel@vger.kernel.org
Cc: hanhbkernel <hanhbkernel@yahoo.com.cn>,
        Syed Mohammad Talha <talha@cbq.com.qa>
Subject: Re: initrd problem of 2.4.10
Message-ID: <20011019141926.B596@mail.wave.co.nz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	hanhbkernel <hanhbkernel@yahoo.com.cn>,
	Syed Mohammad Talha <talha@cbq.com.qa>
In-Reply-To: <20011012052453.72507.qmail@web15001.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20011012052453.72507.qmail@web15001.mail.bjs.yahoo.com>; from hanhbkernel on Fri, Oct 12, 2001 at 01:24:53PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Oct 12, 2001 at 01:24:53PM +0800, hanhbkernel wrote:
> There is no problem using the initial RAM disk
> (initrd) with kernel 2.4.9
> But with kernel 2.4.10 system reports the following
> messages:
> 
> RAMDISK: compressed image found at block 0
> Freeing initrd memory: 1153k freed
> VFS: Mounted root (ext2 filesystem)
> Freeing unused kernel (memory: 224k freed)
> Kernel panic: No init found. Try passing init=option
> to kernel

Check that /lib/ld-* in the initrd has execute permission.

Regards,

Mark.
