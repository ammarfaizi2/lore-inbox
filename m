Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUBFKIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 05:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUBFKIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 05:08:51 -0500
Received: from gw-nl5.philips.com ([161.85.127.51]:43490 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S265379AbUBFKIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 05:08:02 -0500
Message-ID: <4023682E.3060809@basmevissen.nl>
Date: Fri, 06 Feb 2004 11:10:54 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle <kyle@southa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle>
In-Reply-To: <168301c3ec0e$24698be0$b8560a3d@kyle>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:

> hdparm /dev/hda
> /dev/hda:
> multcount = 16 (on)
> IO_support = 1 (32-bit)
> unmaskirq = 1 (on)
> using_dma = 1 (on)
> keepsettings = 0 (off)
> readonly = 0 (off)
> readahead = 256 (on)
> geometry = 30401/255/63, sectors = 488397168, start = 0
> 
> tried with hdparm -a8192 /dev/hda, not much different
> /dev/hdc same as /dev/hda
> 

Looks fine. That's strange. Maybe reboot the system and check 
/proc/interrupts to see if none of them is excessive.

What's your .config? Try with as less as possible IDE stuff enabled.

Bas.


