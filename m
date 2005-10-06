Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVJFFQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVJFFQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 01:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVJFFQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 01:16:38 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:51688 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbVJFFQi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 01:16:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZFHS4Ksypt2XLZuT0yZwIdfomAv9Nn5PnaMf49BBTjfb1BrcPKGc3o7VYkhjVTrmQ0wVuv0cNB+yho4ZMQbczAQeug2oLp5QwZ6qvoeiSjzpw1W74cl8mdZOJ0qzLd8adZohfZN6TK9LGDRWU9Mt931kbaFZIjVMq+MAbR5YIIU=
Message-ID: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>
Date: Thu, 6 Oct 2005 10:46:37 +0530
From: devesh sharma <devesh28@gmail.com>
Reply-To: devesh sharma <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Issues in Booting kernel 2.6.13
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have compiled 2.6.13 kernel on a opteron machine with 1 GB physical
memory, Whole compilation gose well but at the last step
make install I am getting a warning
WARNING: No module mptbase found for kernel 2.6.13, continuing anyway
WARNING: No module mptscsih found for kernel 2.6.13, continuing anyway

now when I boot my kernel, panic is received
Booting the kernel.
Red Hat nash version 4.1.18 starting
mkrootdev: lable / not found
mount: error 2 mounting ext3
mount: error 2 mounting none
switchroot: mount failed : 22
umount : /initrd/dev failed : 22
kernel panic - not syncing : Attempted to kill init

What could be the problem?
I have RHEL 4 base release already installed on which I have compiled
this image.
