Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUF0KXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUF0KXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 06:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUF0KXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 06:23:54 -0400
Received: from mailsrv3.tranzpeer.net ([202.180.66.209]:36069 "EHLO
	mailsrv3.tranzpeer.net") by vger.kernel.org with ESMTP
	id S261602AbUF0KXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 06:23:52 -0400
Message-ID: <40DE9228.2080401@flying-brick.caverock.net.nz>
Date: Sun, 27 Jun 2004 10:23:52 +0100
From: The Viking <viking@flying-brick.caverock.net.nz>
Organization: The Flying Brick System
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: viking@flying-brick.caverock.net.nz
Subject: Re: [PATCH] save kernel version in .config file
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-------- Original Message --------
References: <28jXg-7Hw-3@gated-at.bofh.it> <28lmp-jo-9@gated-at.bofh.it>

On Fri, 18 Jun 2004 08:38:58 +0200 Paul Rolland wrote:

| Hello,
|
| >
| > Is this interesting to anyone besides me?
| >
| Is it also possible to have this version being displayed during
| a make config/make menuconfig/... so that we know we are reading a
| config file that may have been generated for another kernel version,
| and not yet saved ?
|
| You would have, for make menuconfig :
|
|  Linux Kernel v2.2.13 Configuration, Configuration file version 2.4.20

 >Sure, it's possible.  I just don't want to add the kitchen sink.

 >IOW, I'm not convinced that it's useful most of the time...
 >only a little bit of the time.

My two cents worth:
I'd show it if it differed in kernel version, otherwise not. If this code is 
all relatively self contained, such as all being within the menuconfig/xconfig 
code, then it won't affect the running of the kernel. And yes, it would mean a 
little more code in place, but we're waiting for keyboard strokes in this 
code, or viewing its output. It's not timing-critical.

Sorry I took so long to get to this, but I've only caught up to this point.

-- 
2,313 messages to read, 2,313 messages to read - damn, Thunderbird just 
refreshed, 2,847 messages to read, ... (ad nauseum vibrum kernel)

The Viking of the Flying Brick System
