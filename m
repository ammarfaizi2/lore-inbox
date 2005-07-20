Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVGTKyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVGTKyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 06:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVGTKyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 06:54:15 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:17536 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S261153AbVGTKyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 06:54:14 -0400
Message-ID: <42DE2D51.5090105@sm.sony.co.jp>
Date: Wed, 20 Jul 2005 06:54:09 -0400
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Preserve hibenate-system-image on startup
References: <42D9FA0C.3060609@sm.sony.co.jp> <1121619485.13487.11.camel@localhost>
In-Reply-To: <1121619485.13487.11.camel@localhost>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


With this function, system needs to mount read-write file systems on
every boot cycle, due to avoid inconsistency between FS and memory.
How did you address this problem? Did kernel check RW FS remained as
mounted on boot up or hibernate time ?


I think I need to discuss with you at San Jose at the beginning of 
this year.


Regards,
Hiroyuki Machida

Nigel Cunningham wrote:
> Hi.
> 
> We've had this feature in Suspend2 for a couple of years and I can
> confirm that the approach works, provided that the on-disk filesystem
> remains unchanged throughout this. (Useful mainly for kiosks etc).
> 
> This is not to say that I've reviewed the code below for correctness.
> 
> Regards,

