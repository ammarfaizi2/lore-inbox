Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278229AbRJSATR>; Thu, 18 Oct 2001 20:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278237AbRJSATH>; Thu, 18 Oct 2001 20:19:07 -0400
Received: from mail.wave.co.nz ([203.96.216.11]:34628 "EHLO mail.wave.co.nz")
	by vger.kernel.org with ESMTP id <S278236AbRJSASv>;
	Thu, 18 Oct 2001 20:18:51 -0400
Date: Fri, 19 Oct 2001 13:19:13 +1300
From: Mark van Walraven <markv@wave.co.nz>
To: cj <cj@cjcj.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10 etherboot initrd init= problem
Message-ID: <20011019131913.A596@mail.wave.co.nz>
Mail-Followup-To: cj <cj@cjcj.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BB0958B.8030703@cjcj.com> <20011011132047.A401@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3BB0958B.8030703@cjcj.com>; from cj@cjcj.com on Tue, Sep 25, 2001 at 07:32:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 07:32:43AM -0700, cj wrote:
> Kernel panic: No init found.  Try passing init= option to kernel.
> 
> These kernel command lines work with 2.4.9 but not 2.4.10:
> auto rw root=/dev/ram ramdisk_size=8192
> auto rw root=/dev/ram init=/sbin/init ramdisk_size=8192
> auto rw root=/dev/ram init=/bin/ash ramdisk_size=8192

Are the execute permission bits set for /lib/ld-* in your initrd?

Mark.
