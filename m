Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVJ0QKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVJ0QKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVJ0QKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:10:22 -0400
Received: from mail.capitalgenomix.com ([143.247.20.203]:32225 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S1751173AbVJ0QKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:10:22 -0400
Message-ID: <4360FB36.1080404@capitalgenomix.com>
Date: Thu, 27 Oct 2005 12:07:18 -0400
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: [PATCH 1/3] kconfig and lxdialog, kernel 2.6.13.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello group,

The overall purpose of this patch is to add an "Abort" button to the 
exit dialog of "make menuconfig" (kconfig), which returns the user to 
the root menu if he/she chooses the Abort button (useful if the user 
didn't actually want to exit kconfig).  kconfig relies on lxdialog to 
display the exit dialog.  As a result, most functionality changes were 
made to lxdialog.

I have read MAINTAINERS and was unable to locate any maintainer for 
lxdialog.  Please feel free to let me know who should have been included 
on this message and I apologize ahead of time for leaving you out.

This is my first submission to the LKML so please feel free to provide 
me with any feedback before I submit the patches to Linus.

I hope I haven't shot myself in the foot; but, (and please no offense to 
the original author(s)) I was almost totally unable to follow the 
original style from the lxdialog source code (e.g. new blocks were 
spaced two spaces to the left rather than the style I've become 
accustomed to, spacing to the right).  Basically, I ended up running 
Lindent against the source in scripts/lxdialog/ and [naturally] I've now 
made the patch much larger than it should have been (next time I'll read 
the FAQ *before* I start writing a patch and hence the reason I'm 
posting the first patch as a URL).  Hopefully, by submitting the format 
changes first, it will be clear what the important modifications were.  
In other words, the first patch is *only* a format change.  The next two 
patches will be the important functionality modifications to lxdialog 
and kconfig.

Signed-off-by: Sean E. Fao <sean.fao@capitalgenomix.com>

http://www2.capitalgenomix.com/temp/linux_patch/format_patch

-- 
Sean

