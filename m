Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVKHRKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVKHRKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVKHRKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:10:35 -0500
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:14513 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030218AbVKHRKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:10:33 -0500
In-Reply-To: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 12:10:25 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 8, 2005, at 10:48 AM, linux-os ((Dick Johnson)) wrote:

> The Linux fstat() doesn't return any information number of blocks,
> or the byte-length of a physical hard disk.

I don't think (f)stat returns size and blocks information about a  
block device on any UNIX platform.

But I don't know for sure how to get it - perhaps ioctl on the  
device? BLKGETSIZE?

Parag
