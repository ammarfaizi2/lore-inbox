Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752621AbWAHNN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbWAHNN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbWAHNN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:13:27 -0500
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:53509
	"EHLO alpha.ovcam.org") by vger.kernel.org with ESMTP
	id S1752621AbWAHNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:13:26 -0500
Message-ID: <43C10FF1.4000200@ovcam.org>
Date: Sun, 08 Jan 2006 05:13:21 -0800
From: Mark McClelland <mark@ovcam.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051219 SeaMonkey/1.0b
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/media/ov511.c: remove hooks for the decomp
 module
References: <20060106022852.GW12313@stusta.de>
In-Reply-To: <20060106022852.GW12313@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> - the decomp module is not intended for inclusion into the kernel
> - people using the decomp module from upstream will usually simply use
>   the complete upstream 2.xx driver
> 
> Therefore, there seems to be no good reason spending some bytes of 
> kernel memory for hooks for this module.

I've tested this patch and it seems to work OK. Thanks for doing it!

Greg, please apply.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Mark McClelland <mark@ovcam.org>

-- 
Mark McClelland
mark@ovcam.org

