Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292903AbSB0V1I>; Wed, 27 Feb 2002 16:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292963AbSB0V0e>; Wed, 27 Feb 2002 16:26:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292962AbSB0V0U>; Wed, 27 Feb 2002 16:26:20 -0500
Subject: Re: ext3 and undeletion
To: jstrand1@rochester.rr.com (James D Strandboge)
Date: Wed, 27 Feb 2002 21:40:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LINUX-KERNEL)
In-Reply-To: <20020227210026.GA18660@rochester.rr.com> from "James D Strandboge" at Feb 27, 2002 04:00:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gBoU-0005wL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rather than modifying all the different filesystems, or libc, we could
> modify the VFS unlink function in the kernel.  It would therefore work

What about every data loss caused by truncate, overwriting etc..
