Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316428AbSETWsF>; Mon, 20 May 2002 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316429AbSETWsE>; Mon, 20 May 2002 18:48:04 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:45837 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S316428AbSETWsD>; Mon, 20 May 2002 18:48:03 -0400
Date: Tue, 21 May 2002 00:47:57 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [ANN] NTFS 2.0.7d -- PPC updates
Message-ID: <Pine.LNX.4.33.0205210041110.572-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In this version numerous compilation problems were fixed:
 - when HIGHMEM_CONFIG was on and NTFS was compiled to the module, depmod
failed with undefined symbols.
 - when HIGHMEM_CONFIG was on and NTFS was compiled to the module on the
PPC arch, depmod failed with even more undefined symbols; I'd like any of
PPC gurus to verify these changes (one was backported from 2.4.19pre so I
assume it's correct, the other I'm not sure).
 - not used file was removed.
No more known bugs left. The next update is scheduled to sync with either
2.4.19[pre|rc|final] kernel or NTFS 2.0.8 which will be much work in both
cases.

Get it from:
http://linux-ntfs.fs.net/downloads.html

Enjoy.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

