Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272433AbRITSGG>; Thu, 20 Sep 2001 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRITSF5>; Thu, 20 Sep 2001 14:05:57 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:17418 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272433AbRITSFn>; Thu, 20 Sep 2001 14:05:43 -0400
Date: Thu, 20 Sep 2001 20:05:50 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: <linux-kernel@vger.kernel.org>
Subject: noexec-flag does not work in Linux 2.4.10-pre10
Message-ID: <Pine.LNX.4.33.0109201957530.2448-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the noexec in fstab no longer works. Is this
intentional?

In fstab I have the following line:

/dev/hda1       /dosc   vfat    codepage=850,umask=000,noexec 0 0

A ls -l in /dosc shows:

-rwxrwxrwx    1 root     root     267657216 Jun 28 22:34 win386.swp

The same case with iso9660:

-r-xr-xr-x    1 root     root            0 Jan 24  2000 s3cd1.dat

However umask=111 is still working. I don't know exactly when this
happened, but it was hot there in earlier 2.4 kernels.

mfg

Peter B


