Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTIDQsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTIDQsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:48:25 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36063 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261939AbTIDQsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:48:23 -0400
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 4 Sep 2003 09:45:22 -0700 (PDT)
Subject: serial console on x86
Message-ID: <Pine.LNX.4.44.0309040939230.18624-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to install linux (debian 3 based) on some dual athlon
boxes with no video card. The BIOS does include serial console
capabilities

once the system is installed I have no problem booting from the hard
drive, but when I attempt to boot from a CD to install (ISOLINUX custom
boot disk) I see the lilo prompt, the loading kernel message, the loading
initrd.gz message and then it prints 'Ready.' and reboots the same
bootdisk will work just fine if I install a video card in the machine (and
the same kernel with lilo boots just fine without a video card after it
gets installed)

any ideas why the kernel may crash before printing any messages in this
situation? I've tried this with 2.4.17 and 2.4.22 with the exact same
results.

David Lang
