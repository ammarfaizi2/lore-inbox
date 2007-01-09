Return-Path: <linux-kernel-owner+w=401wt.eu-S1750904AbXAIB4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbXAIB4d (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbXAIB4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:56:33 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43681 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbXAIB4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:56:33 -0500
Date: Tue, 9 Jan 2007 02:51:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hua Zhong <hzhong@gmail.com>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, hch@infradead.com,
       kenneth.w.chen@intel.com, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] support O_DIRECT in tmpfs/ramfs
In-Reply-To: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0701090249360.20773@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Jan 8 2007 17:43, Hua Zhong wrote:
>
>1. A new fs flag FS_RAM_BASED is added and the O_DIRECT flag is ignored
>   if this flag is set (suggestions on a better name?)

FS_IGNORE_DIRECT. Somehow I think this flag is not only useful for
RAM-based filesystems, but also possibly virtual filesystems (procfs,
sysfs, etc.) Maybe even more such as fuse and unionfs.


	-`J'
-- 
