Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTEFRfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTEFRfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:35:07 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:39173 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263852AbTEFRfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:35:06 -0400
To: Peder Stray <peder@ifi.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Files truncate on vfat filesystem
References: <wa1ade0gkl3.fsf@tyrfing.ifi.uio.no>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 07 May 2003 02:47:17 +0900
In-Reply-To: <wa1ade0gkl3.fsf@tyrfing.ifi.uio.no>
Message-ID: <87k7d4t1ay.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peder Stray <peder@ifi.uio.no> writes:

> I have a 250GB usb-storage disk i use to transport large files between
> work and home, I uses vfat (since I haven't found any other good
> filesystems that don't require me to either be root or have all files
> worldreadable). Anyways...

What partition size do you use? And does that FAT use what logical
sector size?  The directory entry pointer may be overflowed...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
