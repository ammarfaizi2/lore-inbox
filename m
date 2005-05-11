Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVEKOZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVEKOZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVEKOZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:25:37 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:48486 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261217AbVEKOZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KAV+k5TSCX18RJ9zeaoApxmWvig7k0q09YWZyGghIiSKhQYjvxfSJzGY1kN9ALaIIBP4vcrPV8oKKOdQED5MBhEWcVgSmgnUV7ryTYsARlfVT909R0jUHAQda1x7mRhG6O/0TR73FdxCkWwb0+C1XD/hjulCJMRG8nPE+qMglXA=
Message-ID: <40a4ed5905051107255848f6b1@mail.gmail.com>
Date: Wed, 11 May 2005 16:25:13 +0200
From: Zeno Davatz <zdavatz@gmail.com>
Reply-To: Zeno Davatz <zdavatz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm trying to set up a new server with 2*200GB HD's, 2*Intel Xeon 3.4
GHz and an Intel SE7520BD2 Motherboard (SATA).

I can boot perfectly fine from my Gentoo 2005.0 - minimal-install CD.
The system is up and running except when I want to boot from the
harddisk (root=/dev/sda3 boot=/dev/sda1, both on jfs). I can proof
that by mounting the new system when I boot from CD and do a chroot.

I even tried by compiling the kernel with the /proc/config.gz from the
above CD. Same result as in the subject line:
Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)

Yes, I did run lilo -v and that went smoothly; and I do get the Lilo
manager in the beginning, but after that and some messages: Kernel
panic...

I'm on 2.6.11.8 from kernel.org

Any help is greatly appreciated.

Thanks
Zeno
