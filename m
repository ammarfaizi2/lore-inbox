Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbUJZDAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUJZDAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUJZDAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:00:46 -0400
Received: from orange.ss.cs.osakafu-u.ac.jp ([157.16.33.140]:896 "EHLO
	orange.ss.cs.osakafu-u.ac.jp") by vger.kernel.org with ESMTP
	id S262140AbUJZC64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:58:56 -0400
Date: Tue, 26 Oct 2004 11:58:53 +0900 (JST)
Message-Id: <20041026.115853.74754735.masa@cs.osakafu-u.ac.jp>
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Second SATA disk is not recognized in kernel 2.6.x
From: Masakazu Iwamura <masa@cs.osakafu-u.ac.jp>
In-Reply-To: <58cb370e041025062658d28930@mail.gmail.com>
References: <20041024.021758.130228080.masa@cs.osakafu-u.ac.jp>
	<20041025.192404.59463574.masa@cs.osakafu-u.ac.jp>
	<58cb370e041025062658d28930@mail.gmail.com>
X-Mailer: Mew version 3.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej wrote:
> libata has problems with handling hw RAID connected to the second
> SATA port (?), for now you can revert to using IDE driver, just disable
> CONFIG_SCSI_SATA and enable CONFIG_BLK_DEV_IDE_SATA.

I tried this. But, it did not boot also because of an error related to
IRQ #18.
Anyway, thank you!

masa
