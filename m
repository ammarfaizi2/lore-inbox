Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVCLL1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVCLL1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCLL0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:26:35 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:62692 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261671AbVCLLVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:21:35 -0500
Date: Sat, 12 Mar 2005 03:21:19 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Andrew Morton <akpm@osdl.org>
cc: chaffee@bmrc.berkeley.edu, <mc@cs.Stanford.EDU>,
       <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [CHECKER] crash + fsck cause file systems to contain loops (msdos
 and vfat, 2.6.11)
In-Reply-To: <20050312024114.173114fb.akpm@osdl.org>
Message-ID: <Pine.GSO.4.44.0503120313140.11724-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus's current tree includes support for `mount -o sync' on the msdos and
> vfat filesystems.

Thanks Andrew.  I can just do a bk clone from
http://linux.bkbits.net/linux-2.6 to get Linus's current tree, right?

The warning reported here doesn't need mount -o sync to trigger though.
A simple crash on a default mounted FS can usually cause the FS loop.

(Also, I realized I made many typos in my report --- this implies I'm
tired and should probably get some sleep :)

