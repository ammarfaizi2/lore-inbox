Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754332AbWKMKwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbWKMKwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbWKMKwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:52:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:33528 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754332AbWKMKwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:52:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W+EvhCWQerllXLtWIO4a8gfJ/n61YxKDdmgDeW+4YXQvVpuD9d64G73giDcRgLLh3Nppzenz3iS5dSYUtzYwgVjfTcN/ugb3DMRsVypc3YmD/YmqmUYkZWVdABGx/auCN4LipFWuWuzfpkO4dPkj1YiuXbNke/zGRuKsbut2Nc0=
Message-ID: <a5de567c0611130252m52de5071vc25589bfd89b9c27@mail.gmail.com>
Date: Mon, 13 Nov 2006 13:52:06 +0300
From: "Ivan Ukhov" <uvsoft@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: /dev before the root filesystem is mounted
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want the kernel (2.4) to display (just using printk) all available
devices with full path (/dev/...) before the root filesystem is
mounted. So I'm trying to add something into mount_block_root function
in init/do_mounts.c to do it. But I really haven't got any idia what
exactly I should do. Can you help me please?

Thanks a lot.
